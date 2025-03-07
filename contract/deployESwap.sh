# Local deployment
forge script script/ESwap.s.sol:DeployESwap --rpc-url 127.0.0.1:8545  \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    --broadcast
#   USDC Test Token deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
#   ESwap Contract deployed to: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0

# Testnet deployment
# forge script script/ESwap.s.sol:DeployESwap --rpc-url https://rpc.ankr.com/electroneum_testnet  \
#     --account wallet_test \
#     --broadcast
#     > deployESwap-output.txt

# Production deployment
# forge script script/ESwap.s.sol:DeployESwap --rpc-url https://rpc.ankr.com/electroneum/6de45fb72fd9001245d88887a67835d7fa83dda3d3f32b6b05f85eb384689782 \
#     --account wallet_test \
#     --broadcast > deploymentESwap-output.txt
# Contract address: 