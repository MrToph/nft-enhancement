> [OpenSea](https://opensea.io/assets/ethereum/0xe41d8f993066db39a5bb3015d66a003792121757/611772655137187737006014808458467628071276587481)  
> [Etherscan Deployment](https://etherscan.io/address/0xe41d8f993066db39a5bb3015d66a003792121757#code)  
> [Website](https://MrToph.github.io/nft-enhancement/)

# NFT Filters

- [`app`](./app): The web app to preview how the filters would look like on different NFTs. Can also use the app to set the underlying NFT if you're a filter owner.

    > ℹ [Live version](https://MrToph.github.io/nft-enhancement/)
- [`renderers`](./renderers/templates): Contains the HTML/CSS/JS filters that are used in the `IRenderer` contracts.
- [`src`](./src): The smart contracts for the NFT filters project.
- [`test`](./test): Tests for the smart contracts.
- [`script`](./script): Deployment scripts.

### Setup

```sh
git clone ...
git submodule init

# copy .env.template and fill in the required env vars
cp .env.template .env
```

### Run Tests

```sh
source .env
forge test --fork-url https://eth-mainnet.alchemyapi.io/v2/$ALCHEMY_API_KEY --fork-block-number 15318000 -vvv
```

### Web app testing

```sh
source .env

# start local anvil node forking from mainnet
anvil --accounts 1 --fork-url https://eth-mainnet.alchemyapi.io/v2/$ALCHEMY_API_KEY --fork-block-number 15318000

# deploy NFTEnhancement to local node
forge script script/Deployment.s.sol:Deployment --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY_TEST --broadcast -vvvv

# let web app know the deployment addresses
cp broadcast/Deployment.s.sol/1/run-latest.json app/abis/deployment.json

# start web app
cd app
npm run dev
```

### Deployment

```sh
source .env

# polygon needs legacy because of some gas estimation issues ("transaction underpriced")
forge script script/Deployment.s.sol:Deployment --rpc-url https://polygon-mainnet.g.alchemy.com/v2/$ALCHEMY_API_KEY --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY --chain-id 137 --gas-price 45000000000 --legacy -vvvv
# if verification fails with "Etherscan could not detect the deployment.". Resume script
forge script script/Deployment.s.sol:Deployment --rpc-url https://polygon-mainnet.g.alchemy.com/v2/$ALCHEMY_API_KEY --private-key $PRIVATE_KEY --resume --verify --etherscan-api-key $ETHERSCAN_KEY --chain-id 137 --gas-price 45000000000 --legacy -vvvv

# mainnet
forge script script/Deployment.s.sol:Deployment --rpc-url https://eth-mainnet.alchemyapi.io/v2/$ALCHEMY_API_KEY --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
# if verification fails with "Etherscan could not detect the deployment.". Resume script
forge script script/Deployment.s.sol:Deployment --rpc-url https://eth-mainnet.alchemyapi.io/v2/$ALCHEMY_API_KEY --private-key $PRIVATE_KEY --resume --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
```

#### HTML template preparation

- Use [UglifyJS](https://skalman.github.io/UglifyJS-online/) for the JS part to decrease JS size and turn it into a single line.
