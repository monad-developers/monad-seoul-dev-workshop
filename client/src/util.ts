import { encodeFunctionData, decodeFunctionResult } from "viem";
import { client, pixelMapAddress, multicall3Address } from "./config";
import { PixelMap, multicall3 } from "./abi";

export async function multicallPixelMap(
  calls: { functionName: string; args: unknown[] }[]
) {
  const rawResult = await client.call({
    to: multicall3Address,
    data: encodeFunctionData({
      abi: multicall3,
      functionName: "tryAggregate",
      args: [
        false,
        calls.map(({ functionName, args }) => ({
          target: pixelMapAddress,
          callData: encodeFunctionData({
            abi: PixelMap.abi,
            functionName,
            args,
          }),
        })),
      ],
    }),
  });

  const decodedArray = decodeFunctionResult({
    abi: multicall3,
    functionName: "tryAggregate",
    data: rawResult.data as `0x${string}`,
  }) as { success: boolean; returnData: `0x${string}` }[];

  const decodedResults = decodedArray.map(({ success, returnData }, i) => {
    const { functionName } = calls[i];
    if (!success) {
      return { success, functionName, returnValue: null };
    }

    const returnValue = decodeFunctionResult({
      abi: PixelMap.abi,
      functionName,
      data: returnData,
    });

    return {
      success,
      functionName,
      returnValue,
    };
  });

  if (decodedResults.some((result) => !result.success)) {
    throw new Error("At least one call failed");
  }

  return decodedResults.map((result) => result.returnValue);
}

export const rgbToHex = ([r, g, b]: [number, number, number]): string => {
  return `#${((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)}`;
};

export const hexToRgb = (hex: string): [number, number, number] => {
  const bigint = parseInt(hex.slice(1), 16);
  const r = (bigint >> 16) & 255;
  const g = (bigint >> 8) & 255;
  const b = bigint & 255;
  return [r, g, b];
};

export const truncateAddress = (address: string): string => {
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
};
