# Local deployment
forge create src/$1.sol:$1 --rpc-url 127.0.0.1:8545  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Testnet deployment
#forge create src/$1.sol:$1 --rpc-url https://rpc.ankr.com/electroneum_testnet  --account wallet_test > deployment-output.txt