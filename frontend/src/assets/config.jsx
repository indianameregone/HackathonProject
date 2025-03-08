import { createAppKit } from '@reown/appkit/react'
import { WagmiProvider } from 'wagmi'
import { arbitrum, mainnet, electroneum, electroneumTestnet } from '@reown/appkit/networks'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { WagmiAdapter } from '@reown/appkit-adapter-wagmi'
import { defineChain } from 'viem'

// Define local network
const localNetwork = defineChain({
  id: 31337,
  name: 'Local Network',
  network: 'localhost',
  nativeCurrency: {
    decimals: 18,
    name: 'Ethereum',
    symbol: 'ETH',
  },
  rpcUrls: {
    default: { 
      http: ['http://127.0.0.1:8545'] 
    },
    public: { 
      http: ['http://127.0.0.1:8545'] 
    }
  }
})

// Setup queryClient
const queryClient = new QueryClient()

// Get projectId from https://cloud.reown.com
const projectId = 'YOUR_PROJECT_ID'

// Create metadata object
const metadata = {
  name: 'Hackathon Swap',
  description: 'Token Swap Application',
  url: 'http://localhost:5173', // Update this for production
  icons: ['https://your-icon-url.com']
}

// Set the networks - for local development
const networks = [localNetwork, mainnet] // Add other networks as needed
// const networks = [mainnet, arbitrum, electroneum, electroneumTestnet]

// Create Wagmi Adapter
const wagmiAdapter = new WagmiAdapter({
  networks,
  projectId,
  ssr: true
})

// Create modal
createAppKit({
  adapters: [wagmiAdapter],
  networks,
  projectId,
  metadata,
  features: {
    analytics: true
  }
})

export function AppKitProvider({ children }) {
  return (
    <WagmiProvider config={wagmiAdapter.wagmiConfig}>
      <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
    </WagmiProvider>
  )
}

export function ConnectButton() {
  return <appkit-button />
}