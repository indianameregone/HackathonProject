# Local deployment
forge script script/ESwap.s.sol:DeployESwap --rpc-url 127.0.0.1:8545  \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    --broadcast
#  USDC Test Token deployed to: 0x8A791620dd6260079BF849Dc5567aDC3F2FdC318
#  ESwap deployed to: 0x610178dA211FEF7D417bC0e6FeD39F05609AD788

# Testnet deployment
# forge script script/ESwap.s.sol:DeployESwap --rpc-url https://rpc.ankr.com/electroneum_testnet  \
#     --account wallet_test \
#     --broadcast
#     > deployESwap-output.txt