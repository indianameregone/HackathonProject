# Local deployment
# First, let's check who the owner is
cast call --rpc-url 127.0.0.1:8545 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707 "owner()" 

# Mint using Etoken smartcontract
cast send --rpc-url 127.0.0.1:8545  \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707 \
    "mint(address,uint256)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 1000

# Check balance of user minting
cast call --verbose --rpc-url 127.0.0.1:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707 \
    "balanceOf(address)" \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
    | cast --to-dec