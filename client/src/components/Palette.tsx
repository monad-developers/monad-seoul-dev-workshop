import { HexColorPicker } from "react-colorful";
import { rgbAtom } from "../atom";
import { useAtom } from "jotai";
import { rgbToHex, hexToRgb } from "../util";

export function Palette() {
  const [color, setColor] = useAtom(rgbAtom);

  return (
    <HexColorPicker
      color={rgbToHex(color)}
      onChange={(newColor) => setColor(hexToRgb(newColor))}
    />
  );
}
