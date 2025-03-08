// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/ESwap.sol"; // Path to smart contract
import "../src/USDCTest.sol";  // Import USDCTest contract

contract DeployESwap is Script {
    function run() external {
        // Define deployment parameters
        address owner = msg.sender;  // Or specify another owner address
        address tokenA = 0x5FbDB2315678afecb367f032d93F642f64180aa3;  // EToken address
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