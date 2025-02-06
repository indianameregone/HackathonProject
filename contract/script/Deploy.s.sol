// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Counter.sol";
import {Script, console} from "forge-std/Script.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Counter contractInstance = new Counter();
        console.log("Contract deployed to:", address(contractInstance));

        vm.stopBroadcast();
    }
}
