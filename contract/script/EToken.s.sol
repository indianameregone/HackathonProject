// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/EToken.sol"; // Path to smart contract

contract DeployEToken is Script {
    function run() external {
        vm.startBroadcast(); // Start broadcasting transactions
        new EToken(msg.sender); // Deploy contract
        vm.stopBroadcast(); // Stop broadcasting transactions
    }
}