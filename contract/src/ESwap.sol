// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LaySwap is Ownable {
    IERC20 public  tokenA;
    IERC20 public  tokenB;

    uint256 public rateAtoB; 
    uint256 public rateBtoA; 


    constructor( address initialOwner, address _tokenA, address _tokenB, uint256 _rateAtoB, uint256 _rateBtoA) Ownable(initialOwner) {
        tokenA = ERC20(_tokenA);
        tokenB = ERC20(_tokenB);
        rateAtoB = _rateAtoB;
        rateBtoA = _rateBtoA;
    }
   
    event Swapped(address indexed user, address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);

    function swapAtoB(uint256 amountA) external {
        require(amountA > 0, "Amount must be greater than zero");
        uint256 amountB = amountA * rateAtoB;

        // Ensure the contract has enough Token B
        require(tokenB.balanceOf(address(this)) >= amountB, "Insufficient liquidity in contract");

        // Transfer Token A from the user to the contract
        tokenA.transferFrom(msg.sender, address(this), amountA);
        
        // Transfer Token B to the user
        tokenB.transfer(msg.sender, amountB);
        
        emit Swapped(msg.sender, address(tokenA), address(tokenB), amountA, amountB);
    }

     function swapBtoA(uint256 amountB) external {
        require(amountB > 0, "Amount must be greater than zero");
        uint256 amountA = amountB * rateBtoA;

        // Ensure the contract has enough Token A
        require(tokenA.balanceOf(address(this)) >= amountA, "Insufficient liquidity in contract");

        // Transfer Token B from the user to the contract
        tokenB.transferFrom(msg.sender, address(this), amountB);

        // Transfer Token A to the user
        tokenA.transfer(msg.sender, amountA);
        
        emit Swapped(msg.sender, address(tokenB), address(tokenA), amountB, amountA);
    }

    function setRates(uint256 _rateAtoB, uint256 _rateBtoA) external onlyOwner {
        rateAtoB = _rateAtoB;
        rateBtoA = _rateBtoA;
    }

    function withdraw(address token, uint256 amount) external onlyOwner {
        IERC20(token).transfer(msg.sender, amount);
    }
    
}

