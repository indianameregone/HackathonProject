// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract EStake {
    address immutable public owner;
    IERC20 public rewardToken;
     IERC20 public poolToken;
    uint256 immutable public stakingProgramEndsBlock;

    struct Stake {
        uint72 tokenAmount;                   // Amount of tokens locked in a stake                                                             
        uint24 lockingPeriodInBlocks;         // Arbitrary lock period that will give you a reward                                    
        uint32 startBlock;                    // Start of the locking                                                                            
        uint128 expectedStakingRewardPoints;  // The amount of RewardPoints the stake will earn if not unlocked prematurely    
    }

    mapping (address => Stake) public stakes;
    mapping (address => uint128) public rewardPointsEarned;
    // 
    uint256 public totalRewardPoints;
    uint256 immutable public stakingFundAmount;

   
   


    /// @dev Used only in setPoolToken()
    modifier onlyOwner() {
        require(msg.sender == owner, "Can only be called by owner");
        _;
    }

    modifier poolTokenSet() {
        require(address(poolToken) != address(0x0), "poolToken not set");
        _;
    }


    constructor(address rewardToken_, uint256 stakingDurationInBlocks_, uint256 stakingFundAmount_, address owner_) {
        require(owner_ != address(0x0), "Owner address cannot be zero");
        owner = owner_;

        require(rewardToken_ != address(0x0), "oilerToken address cannot be zero");
        rewardToken = IERC20(rewardToken_);
        
        stakingProgramEndsBlock = block.number + stakingDurationInBlocks_;

        stakingFundAmount = stakingFundAmount_;
    }


    function setPoolToken(address poolToken_, address stakingFundAddress_) public onlyOwner {
        require(address(poolToken) == address(0x0), "poolToken was already set");
        require(poolToken_ != address(0x0), "poolToken address cannot be zero");
        poolToken = IERC20(poolToken_);
        // Transfer the Staking Bonus Funds from stakingFundAddress here
        require(IERC20(rewardToken).balanceOf(stakingFundAddress_) >= stakingFundAmount, "StakingFund doesn't have enough OIL balance");
        require(IERC20(rewardToken).allowance(stakingFundAddress_, address(this)) >= stakingFundAmount, "StakingFund doesn't have enough allowance");
        require(IERC20(rewardToken).transferFrom(stakingFundAddress_, address(this), stakingFundAmount), "TransferFrom of OIL from StakingFund failed");
    }

    function calculateStakingRewardPoints(uint72 tokenAmount_, uint24 lockingPeriodInBlocks_) public pure returns (uint128) {
        uint256 stakingRewardPoints = uint256(tokenAmount_) * uint256(lockingPeriodInBlocks_) * uint256(lockingPeriodInBlocks_);
        require(stakingRewardPoints > 0, "Neither tokenAmount nor lockingPeriod couldn't be 0");
        return uint128(stakingRewardPoints);
    }

    function lockTokens(uint72 tokenAmount_, uint24 lockingPeriodInBlocks_) public poolTokenSet {
        // Here we don't check lockingPeriodInBlocks_ for being non-zero, cause its happening in calculateStakingRewardPoints() calculation
        require(block.number <= stakingProgramEndsBlock - lockingPeriodInBlocks_, "Your lock period exceeds Staking Program duration");
        require(stakes[msg.sender].tokenAmount == 0, "Already staking");

        // This is a locking reward - will be earned only after the full lock period is over - otherwise not applicable
        uint128 expectedStakingRewardPoints = calculateStakingRewardPoints(tokenAmount_, lockingPeriodInBlocks_);

        Stake memory stake = Stake(tokenAmount_, lockingPeriodInBlocks_, uint32(block.number), expectedStakingRewardPoints);
        stakes[msg.sender] = stake;
        
        // We add the rewards initially during locking of tokens, and subtract them later if unlocking is made prematurely
        // That prevents us from waiting for all users to unlock to distribute the rewards after Staking Program Ends
        totalRewardPoints += expectedStakingRewardPoints;
        rewardPointsEarned[msg.sender] += expectedStakingRewardPoints;
        
        // We transfer LP tokens from user to this contract, "locking" them
        // We don't check for allowances or balance cause it's done within the transferFrom() and would only raise gas costs
        require(poolToken.transferFrom(msg.sender, address(this), tokenAmount_), "TransferFrom of poolTokens failed");

        emit StakeLocked(msg.sender, tokenAmount_, lockingPeriodInBlocks_, expectedStakingRewardPoints);
    }

    function unlockTokens() public poolTokenSet {
        Stake memory stake = stakes[msg.sender];

        uint256 stakeAmount = stake.tokenAmount;

        require(stakeAmount != 0, "You don't have a stake to unlock");

        require(block.number > stake.startBlock, "You can't withdraw the stake in the same block it was locked");

        // Check if the unlock is called prematurely - and subtract the reward if it is the case
        _punishEarlyWithdrawal(stake);

        // Zero the Stake - to protect from double-unlocking and to be able to stake again
        delete stakes[msg.sender];

        require(poolToken.transfer(msg.sender, stakeAmount), "Pool token transfer failed");
    }

    function _punishEarlyWithdrawal(Stake memory stake_) internal {
        // As any of the locking periods can't be longer than Staking Program end block - this will automatically mean that if called after Staking Program end - all stakes locking periods are over
        // So no rewards can be manipulated after Staking Program ends
        if (block.number < (stake_.startBlock + stake_.lockingPeriodInBlocks)) { // lt - cause you can only withdraw at or after startBlock + lockPeriod
            rewardPointsEarned[msg.sender] -= stake_.expectedStakingRewardPoints;
            totalRewardPoints -= stake_.expectedStakingRewardPoints;
            emit StakeUnlockedPrematurely(msg.sender, stake_.tokenAmount, stake_.lockingPeriodInBlocks, block.number - stake_.startBlock);
        } else {
            emit StakeUnlocked(msg.sender, stake_.tokenAmount, stake_.lockingPeriodInBlocks, stake_.expectedStakingRewardPoints);
        }
    }

    function getRewards() public {
        require(block.number > stakingProgramEndsBlock, "You can only get Rewards after Staking Program ends");
        require(stakes[msg.sender].tokenAmount == 0, "You still have a stake locked - please unlock first, don't leave free money here");
        require(rewardPointsEarned[msg.sender] > 0, "You don't have any rewardPoints");
      
        uint256 amountEarned = stakingFundAmount * rewardPointsEarned[msg.sender] / totalRewardPoints;
        rewardPointsEarned[msg.sender] = 0; // Zero rewardPoints of a user - so this function can be called only once per user

        require(rewardToken.transfer(msg.sender, amountEarned), "Transfer of rewards failed");
    }
  


    event RewardGranted(address recipient, uint256 amountEarned);
    event StakeLocked(address recipient, uint256 tokenAmount, uint256 lockingPeriodInBlocks, uint256 expectedStakingRewardPoints);
    event StakeUnlockedPrematurely(address recipient, uint256 tokenAmount, uint256 lockingPeriodInBlocks, uint256 actualLockingPeriodInBlocks);
    event StakeUnlocked(address recipient, uint256 tokenAmount, uint256 lockingPeriodInBlocks, uint256 rewardPoints);
    

}