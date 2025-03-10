# Monad Seoul Dev Workshop

Welcome to the Monad Seoul Dev Workshop! In this workshop, you'll build a decentralized pixel map application similar to Reddit's r/place, where users can collaborate on a shared canvas by coloring individual pixels.

## About the Project

This project is a decentralized version of Reddit's r/place experiment, where users can place colored pixels on a shared canvas. Each pixel has RGB values that can be set by any user. The pixel data is stored on the Monad blockchain, making it truly decentralized and persistent.

## Prerequisites

Before starting, make sure you have the following installed:

- [Foundry](https://book.getfoundry.sh/getting-started/installation) for smart contract development and testing
- [Node.js](https://nodejs.org/) version 20 or higher
- [pnpm](https://pnpm.io/installation) for package management

## Project Structure

```
├── foundry/              # Smart contract development
│   ├── src/              # Contract source files
│   │   └── PixelMap.sol  # The main contract to implement
│   └── test/             # Test files for contracts
│       └── PixelMap.t.sol # Tests for PixelMap contract
│
└── client/               # Frontend application
    ├── src/              # Source files
    │   └── config.ts     # Configuration file for contract addresses
    └── ...               # Other frontend files
```

## Workshop Tasks

### 1. Setup

Clone the repository and install dependencies:

```bash
# Clone the repository (URL to be provided by workshop organizers)
git clone <repository-url>
cd monad-seoul-dev-workshop

# Install Foundry dependencies
cd foundry
forge install

# Install frontend dependencies
cd ../client
pnpm install
```

### 2. Implement the PixelMap Contract

Open the `foundry/src/PixelMap.sol` file. You'll find a template with TODO comments indicating what needs to be implemented:

1. Complete the constructor to initialize the pixel map with white pixels
2. Implement the `setPixel` function to change a pixel's color
3. Implement the `readPixel` function to get a pixel's color

Key implementation details:
- The contract creates a 2D map of pixels, each with RGB values
- The constructor initializes all pixels as white (255, 255, 255)
- The `setPixel` function should validate coordinates before updating pixels
- The `readPixel` function should validate coordinates before reading pixels

### 3. Test Your Implementation

Run the Foundry tests to verify your implementation:

```bash
cd foundry
forge test -vv
```

All tests should pass if your implementation is correct. The tests check:
- Proper initialization of the pixel map
- Setting and reading pixels
- Multiple pixel operations
- Handling of boundary conditions
- Error cases for invalid coordinates

### 4. (Optional) Deploy and Run the Frontend

If you want to see your contract in action:

1. Deploy your contract to Monad Testnet:

```bash
cd foundry
forge script script/PixelMap.sol --rpc-url https://testnet-rpc.monad.xyz/ --private-key YOUR_PRIVATE_KEY --broadcast
```

2. Update the contract address in `client/src/config.ts`:

```typescript
// Replace with your deployed contract address
export const pixelMapAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS";
```

3. Run the frontend:

```bash
cd client
pnpm dev
```

4. Open your browser at `http://localhost:5173` to interact with your PixelMap contract!

## Additional Resources

- [Monad Documentation](https://docs.monad.xyz/)
- [Foundry Documentation](https://book.getfoundry.sh/)
- [Reddit r/place Explained](https://en.wikipedia.org/wiki/Place_(Reddit))

## Troubleshooting

If you encounter any issues:

- Make sure you have the correct versions of Node.js and pnpm
- Check that Foundry is properly installed
- For deployment issues, ensure you have MON testnet tokens (available from faucets)
- Make sure your implementation follows the requirements in the comments

Happy coding!
