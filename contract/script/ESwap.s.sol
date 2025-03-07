// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/ESwap.sol"; // Path to smart contract
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDCTest is ERC20 {
    constructor() ERC20("USDC Test Token", "tUSDC") {
        // Mint 1 million tokens to the deployer (with 6 decimals like real USDC)
        _mint(msg.sender, 1_000_000 * 10**6);
    }

    // Override decimals to match real USDC (6 decimals instead of default 18)
    function decimals() public pure override returns (uint8) {
        return 6;
    }
}

contract DeployESwap is Script {
    function run() external {
        // Define deployment parameters
        address owner = msg.sender;  // Or specify another owner address
        address tokenA = 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707;  // EToken address
        address tokenB;
        uint256 rateAtoB = 1;  // Define your initial exchange rate A to B
        uint256 rateBtoA = 1;  // Define your initial exchange rate B to A

        vm.startBroadcast(); // Start broadcasting transactions
        USDCTest usdc = new USDCTest();
        ESwap eswap = new ESwap(
            owner,
            tokenA,
            tokenB = address(usdc), // Use the deployed USDC as tokenB
            rateAtoB,
            rateBtoA
        );
        console.log("USDC Test Token deployed to:", address(usdc));
        console.log("ESwap deployed to:", address(eswap));
        vm.stopBroadcast(); // Stop broadcasting transactions
    }
}