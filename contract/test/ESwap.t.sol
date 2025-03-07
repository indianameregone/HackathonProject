// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {ESwap} from "../src/ESwap.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Define MockERC20 contract inline
contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract ESwapTest is Test {
    ESwap public eswap;
    MockERC20 public tokenA;
    MockERC20 public tokenB;
    address public owner;
    address public user;

    uint256 public constant INITIAL_SUPPLY = 1000000 * 10**18;
    uint256 public constant INITIAL_RATE_A_TO_B = 2;
    uint256 public constant INITIAL_RATE_B_TO_A = 1;

    function setUp() public {
        owner = address(this);
        user = address(0x1);

        // Deploy mock tokens
        tokenA = new MockERC20("Token A", "TKA");
        tokenB = new MockERC20("Token B", "TKB");

        // Deploy ESwap
        eswap = new ESwap(
            owner,
            address(tokenA),
            address(tokenB),
            INITIAL_RATE_A_TO_B,
            INITIAL_RATE_B_TO_A
        );

        // Mint tokens to contract and user
        tokenA.mint(address(eswap), INITIAL_SUPPLY);
        tokenB.mint(address(eswap), INITIAL_SUPPLY);
        tokenA.mint(user, INITIAL_SUPPLY);
        tokenB.mint(user, INITIAL_SUPPLY);

        // Give allowance from user to contract
        vm.startPrank(user);
        tokenA.approve(address(eswap), type(uint256).max);
        tokenB.approve(address(eswap), type(uint256).max);
        vm.stopPrank();
    }

    function testInitialState() public view{
        assertEq(address(eswap.tokenA()), address(tokenA));
        assertEq(address(eswap.tokenB()), address(tokenB));
        assertEq(eswap.rateAtoB(), INITIAL_RATE_A_TO_B);
        assertEq(eswap.rateBtoA(), INITIAL_RATE_B_TO_A);
    }

    function testSwapAtoB() public {
        uint256 amountIn = 100 * 10**18;
        uint256 expectedAmountOut = amountIn * INITIAL_RATE_A_TO_B;
        
        uint256 userInitialBalanceA = tokenA.balanceOf(user);
        uint256 userInitialBalanceB = tokenB.balanceOf(user);

        vm.prank(user);
        eswap.swapAtoB(amountIn);

        assertEq(tokenA.balanceOf(user), userInitialBalanceA - amountIn);
        assertEq(tokenB.balanceOf(user), userInitialBalanceB + expectedAmountOut);
    }

    function testSwapBtoA() public {
        uint256 amountIn = 100 * 10**18;
        uint256 expectedAmountOut = amountIn * INITIAL_RATE_B_TO_A;
        
        uint256 userInitialBalanceA = tokenA.balanceOf(user);
        uint256 userInitialBalanceB = tokenB.balanceOf(user);

        vm.prank(user);
        eswap.swapBtoA(amountIn);

        assertEq(tokenB.balanceOf(user), userInitialBalanceB - amountIn);
        assertEq(tokenA.balanceOf(user), userInitialBalanceA + expectedAmountOut);
    }

    function testSetRates() public {
        uint256 newRateAtoB = 3;
        uint256 newRateBtoA = 2;

        eswap.setRates(newRateAtoB, newRateBtoA);

        assertEq(eswap.rateAtoB(), newRateAtoB);
        assertEq(eswap.rateBtoA(), newRateBtoA);
    }

    function testWithdraw() public {
        uint256 withdrawAmount = 100 * 10**18;
        uint256 initialBalance = tokenA.balanceOf(owner);

        eswap.withdraw(address(tokenA), withdrawAmount);

        assertEq(tokenA.balanceOf(owner), initialBalance + withdrawAmount);
    }

    function testFailSwapInsufficientLiquidity() public {
        // Withdraw all tokenB from contract
        eswap.withdraw(address(tokenB), tokenB.balanceOf(address(eswap)));

        uint256 amountIn = 100 * 10**18;
        
        vm.prank(user);
        eswap.swapAtoB(amountIn); // Should fail due to insufficient liquidity
    }

    function testFailSwapZeroAmount() public {
        vm.prank(user);
        eswap.swapAtoB(0); // Should fail due to zero amount
    }

    function testFailUnauthorizedSetRates() public {
        vm.prank(user);
        eswap.setRates(3, 2); // Should fail as user is not owner
    }

    function testFailUnauthorizedWithdraw() public {
        vm.prank(user);
        eswap.withdraw(address(tokenA), 100 * 10**18); // Should fail as user is not owner
    }
} 