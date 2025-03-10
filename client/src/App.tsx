import { PixelMap, Palette } from "./components";

function App() {
  return (
    <div className="flex flex-row w-screen h-screen items-center justify-evenly">
      <PixelMap />
      <Palette />
    </div>
  );
}

export default App;
