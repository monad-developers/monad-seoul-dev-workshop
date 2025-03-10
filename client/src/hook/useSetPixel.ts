import { useCallback, useState } from "react";
import {
  createWalletClient,
  custom,
  encodeFunctionData,
  WalletClient,
} from "viem";
import { chain, pixelMapAddress } from "../config";
import { PixelMap } from "../abi";

export function useSetPixel() {
  const [walletClient, setWalletClient] = useState<WalletClient | null>(null);

  const connect = useCallback(async (): Promise<WalletClient> => {
    if (walletClient?.account) return walletClient;

    const [account] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });

    const client = createWalletClient({
      account,
      transport: custom(window.ethereum!),
      chain,
    });

    try {
      await client.switchChain({ id: chain.id });
    } catch {
      await client.addChain({ chain });
      await client.switchChain({ id: chain.id });
    }

    setWalletClient(client);
    return client;
  }, [walletClient]);

  const setPixel = useCallback(
    async (x: number, y: number, color: [number, number, number]) => {
      const client = await connect();

      if (!client.account) return;

      const hash = await client.sendTransaction({
        chain,
        account: client.account.address as `0x${string}`,
        to: pixelMapAddress,
        data: encodeFunctionData({
          abi: PixelMap.abi,
          functionName: "setPixel",
          args: [x, y, ...color],
        }),
      });

      console.log(hash);
    },
    [connect]
  );

  return {
    setPixel,
  };
}
