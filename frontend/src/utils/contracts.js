import { ethers } from 'ethers';
import ETokenABI from '../../../contract/out/EToken.sol/EToken.json';
import ESwapABI from '../../../contract/out/ESwap.sol/ESwap.json';
import USDCTestABI from '../../../contract/out/USDCTest.sol/USDCTest.json';

export const CONTRACT_ADDRESSES = {
  USDC: "0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e",
  ESWAP: "0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0",
  ETOKEN: "0x5FbDB2315678afecb367f032d93F642f64180aa3"
};