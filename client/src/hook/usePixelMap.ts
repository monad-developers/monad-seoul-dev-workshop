import useSWR from "swr";
import { multicallPixelMap } from "../util";

const fetcher = async () => {
  const [width, height] = (
    await multicallPixelMap([
      { functionName: "width", args: [] },
      { functionName: "height", args: [] },
    ])
  ).map((result: unknown) => Number(result));

  const calls = [];
  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      calls.push({ functionName: "readPixel", args: [x, y] });
    }
  }
  const results = await multicallPixelMap(calls);
  const pixelMap = [];
  for (let y = 0; y < height; y++) {
    const row = [];
    for (let x = 0; x < width; x++) {
      row.push(results[y * width + x]);
    }
    pixelMap.push(row);
  }
  return pixelMap as [number, number, number][][];
};

export function usePixelMap() {
  const { data, error, mutate } = useSWR("pixelMap", fetcher, {
    keepPreviousData: true,
    refreshInterval: 1000,
    dedupingInterval: 0,
  });

  return { data, loading: !data && !error, reload: mutate };
}
