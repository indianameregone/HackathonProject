// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../src/EStake.sol";

contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1e24); // Mint 1 million tokens
    }
}

contract EStakeTest is Test {
    LayStaking public staking;
    MockERC20 public rewardToken;
    MockERC20 public poolToken;
    address public owner = address(1);
    address public user = address(2);
    uint256 public stakingDuration = 100;
    uint256 public stakingFundAmount = 1e9;

    function setUp() public {
        rewardToken = new MockERC20("RewardToken", "RTK");
        poolToken = new MockERC20("PoolToken", "PTK");

        rewardToken.transfer(owner, stakingFundAmount);
        // rewardToken.transfer(user, stakingFundAmount);

        poolToken.transfer(owner, stakingFundAmount);
        poolToken.transfer(user, stakingFundAmount);

        vm.prank(owner);
        staking = new LayStaking(address(rewardToken), stakingDuration, stakingFundAmount, owner);
    }

    function testSetPoolToken() public {
        vm.startPrank(owner);
        rewardToken.approve(address(staking), stakingFundAmount);
        staking.setPoolToken(address(poolToken), owner);
        assertEq(address(staking.poolToken()), address(poolToken));
        vm.stopPrank();
    }

    function testLockTokens() public {
        vm.startPrank(owner);
        rewardToken.transfer(owner, stakingFundAmount);
        rewardToken.approve(address(staking), stakingFundAmount);
        staking.setPoolToken(address(poolToken), owner);
        vm.stopPrank();

        vm.startPrank(user);
        poolToken.transfer(user, 1000);
        poolToken.approve(address(staking), 1000);
        
        staking.lockTokens(1000, 50);
        (uint72 amount,,,) = staking.stakes(user);
        assertEq(amount, 1000);
        vm.stopPrank();
    }

    function testUnlockTokens() public {
        testLockTokens();
        vm.roll(block.number + 51);
        vm.startPrank(user);
        staking.unlockTokens();
        (uint72 amount,,,) = staking.stakes(user);
        assertEq(amount, 0);
        vm.stopPrank();
    }

    function testGetRewards() public {
        testUnlockTokens();
        vm.roll(block.number + stakingDuration);
        vm.startPrank(user);
        staking.getRewards();
        assertEq(rewardToken.balanceOf(user), stakingFundAmount);
        vm.stopPrank();
    }
}
