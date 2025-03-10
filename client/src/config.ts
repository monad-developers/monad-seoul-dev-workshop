import { createPublicClient, http } from "viem";

export const chain = {
  id: 10143,
  name: "Monad Testnet",
  nativeCurrency: { name: "Monad", symbol: "MON", decimals: 18 },
  rpcUrls: { default: { http: ["https://testnet-rpc.monad.xyz/"] } },
};

export const client = createPublicClient({
  chain,
  transport: http(),
});

export const pixelMapAddress = "0x64BDC8e922AA7E09567c15A95584D4fd4e6124ce";
export const multicall3Address = "0xcA11bde05977b3631167028862bE2a173976CA11";
