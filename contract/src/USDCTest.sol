// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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