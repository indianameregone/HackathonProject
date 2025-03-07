# Local deployment
#  USDC Test Token deployed to: 0x8A791620dd6260079BF849Dc5567aDC3F2FdC318
#  ESwap deployed to: 0x610178dA211FEF7D417bC0e6FeD39F05609AD788
#  EToken deployed to: 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707
echo -e "\nChecking deployer's USDC balance..."
cast call --rpc-url 127.0.0.1:8545 \
    0x8A791620dd6260079BF849Dc5567aDC3F2FdC318 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec

# echo -e "\nTransferring USDC Test tokens to ESwap contract..."
# cast send --rpc-url 127.0.0.1:8545 \
#     --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
#     0x8A791620dd6260079BF849Dc5567aDC3F2FdC318 \
#     "transfer(address,uint256)" \
#     0x610178dA211FEF7D417bC0e6FeD39F05609AD788 \
#     1000

echo -e "\n1. Approving ESwap contract to spend 100 EToken tokens..."
cast send --rpc-url 127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    0x5FC8d32690cc91D4c39d9d3abcBD16989F875707 \
    "approve(address,uint256)" \
    0x610178dA211FEF7D417bC0e6FeD39F05609AD788 100

echo -e "\n2. Checking allowance approved..."
cast call --rpc-url 127.0.0.1:8545 \
    0x5FC8d32690cc91D4c39d9d3abcBD16989F875707 \
    "allowance(address,address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    0x610178dA211FEF7D417bC0e6FeD39F05609AD788 | cast --to-dec

echo -e "\n3. Performing swap of EToken for USDC on ESwap..."
cast send --rpc-url 127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    0x610178dA211FEF7D417bC0e6FeD39F05609AD788 \
    "swapAtoB(uint256)" \
    100

echo -e "\n4. Checking USDC balance after swap..."
cast call --rpc-url 127.0.0.1:8545 \
    0x8A791620dd6260079BF849Dc5567aDC3F2FdC318 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec

echo -e "\n4. Checking EToken balance after swap..."
cast call --rpc-url 127.0.0.1:8545 \
    0x5FC8d32690cc91D4c39d9d3abcBD16989F875707 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec