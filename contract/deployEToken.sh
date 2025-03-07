# Local deployment
# forge script script/EToken.s.sol:DeployEToken --rpc-url 127.0.0.1:8545  \
#     --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
#     --broadcast
# Contract address: 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707

# Testnet deployment
# forge script script/EToken.s.sol:DeployEToken --rpc-url https://rpc.ankr.com/electroneum_testnet \
#     --account wallet_test \
#     --broadcast > deployment-output.txt
# Contract address: 0xcD9b83F9033119cA635f6d5d7e8c74C0cF2a5982

# Production deployment
forge script script/EToken.s.sol:DeployEToken --rpc-url https://rpc.ankr.com/electroneum/6de45fb72fd9001245d88887a67835d7fa83dda3d3f32b6b05f85eb384689782 \
    --account wallet_test \
    --broadcast > deploymentEtoken-output.txt
# Contract address: 0xcD9b83F9033119cA635f6d5d7e8c74C0cF2a5982