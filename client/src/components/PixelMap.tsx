import { usePixelMap, useSetPixel } from "../hook";
import { rgbAtom } from "../atom";
import { useAtomValue } from "jotai";

const gridSize = 400 as const;

export function PixelMap() {
  const { data, loading, reload } = usePixelMap();
  const { setPixel } = useSetPixel();
  const rgb = useAtomValue(rgbAtom);

  if (loading) {
    return (
      <div
        className={`w-[400px] h-[400px] m-10 flex items-center justify-center`}
      >
        Loading...
      </div>
    );
  }

  if (!data || data.length === 0) {
    return (
      <div
        className={`w-[400px] h-[400px] m-10 flex items-center justify-center`}
      >
        No data
      </div>
    );
  }

  const cellWidth = `calc(${gridSize}px / ${data[0].length})`;
  const cellHeight = `calc(${gridSize}px / ${data.length})`;

  const handleClick = async (x: number, y: number) => {
    await setPixel(x, y, rgb);
    await reload();
  };

  return (
    <div
      className="grid w-fit h-fit m-10 border-2 border-black "
      style={{
        gridTemplateColumns: `repeat(${data[0].length}, ${cellWidth})`,
        gridTemplateRows: `repeat(${data.length}, ${cellHeight})`,
      }}
    >
      {data.map((row, rowIndex) =>
        row.map(([r, g, b], colIndex) => {
          return (
            <div
              key={`${rowIndex}-${colIndex}`}
              className="pixel-cell cursor-pointer"
              style={{ backgroundColor: `rgb(${r}, ${g}, ${b})` }}
              onClick={() => handleClick(colIndex, rowIndex)}
            />
          );
        })
      )}
    </div>
  );
}
