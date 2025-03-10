// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PixelMap} from "../src/PixelMap.sol";

contract CounterScript is Script {
    PixelMap public pixelMap;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        pixelMap = new PixelMap(10, 10); // Adjust the dimensions as needed

        vm.stopBroadcast();
    }
}
