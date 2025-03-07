# Local deployment
#   USDC Test Token deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
#   ESwap Contract deployed to: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
#   EToken deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
echo -e "\nChecking deployer's USDC balance..."
cast call --rpc-url 127.0.0.1:8545 \
    0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec

# echo -e "\nTransferring USDC Test tokens to ESwap contract..."
# cast send --rpc-url 127.0.0.1:8545 \
#     --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
#     0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 \
#     "transfer(address,uint256)" \
#     0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 \
#     1000

echo -e "\n1. Approving ESwap contract to spend 100 EToken tokens..."
cast send --rpc-url 127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "approve(address,uint256)" \
    0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 100

echo -e "\n2. Checking allowance approved..."
cast call --rpc-url 127.0.0.1:8545 \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "allowance(address,address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 | cast --to-dec

echo -e "\n3. Performing swap of EToken for USDC on ESwap..."
cast send --rpc-url 127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 \
    "swapAtoB(uint256)" \
    100

echo -e "\n4. Checking USDC balance after swap..."
cast call --rpc-url 127.0.0.1:8545 \
    0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec

echo -e "\n4. Checking EToken balance after swap..."
cast call --rpc-url 127.0.0.1:8545 \
    0x5FbDB2315678afecb367f032d93F642f64180aa3 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec