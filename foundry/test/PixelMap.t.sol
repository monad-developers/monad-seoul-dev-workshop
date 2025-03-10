// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PixelMap} from "../src/PixelMap.sol";

/**
 * @title PixelMap Test Suite
 * @notice Tests to verify the correct implementation of the PixelMap contract
 */
contract PixelMapTest is Test {
    PixelMap public pixelMap;
    uint public constant MAP_WIDTH = 10;
    uint public constant MAP_HEIGHT = 10;

    function setUp() public {
        pixelMap = new PixelMap(MAP_WIDTH, MAP_HEIGHT);
    }

    /**
     * @notice Test initialization of the pixel map
     * @dev Verifies dimensions and initial white color of pixels
     */
    function test_initialization() public {
        // Check dimensions
        assertEq(pixelMap.width(), MAP_WIDTH);
        assertEq(pixelMap.height(), MAP_HEIGHT);
        
        // Check that initial pixels are white (255, 255, 255)
        for (uint y = 0; y < MAP_HEIGHT; y++) {
            for (uint x = 0; x < MAP_WIDTH; x++) {
                (uint8 r, uint8 g, uint8 b) = pixelMap.readPixel(x, y);
                assertEq(r, 255);
                assertEq(g, 255);
                assertEq(b, 255);
            }
        }
    }

    /**
     * @notice Test setting and reading a single pixel
     */
    function test_setPixel() public {
        pixelMap.setPixel(0, 0, 11, 12, 13);
        (uint8 r, uint8 g, uint8 b) = pixelMap.readPixel(0, 0);
        assertEq(r, 11);
        assertEq(g, 12);
        assertEq(b, 13);
    }

    /**
     * @notice Test setting and reading multiple pixels
     */
    function test_multiplePixels() public {
        // Set a few different pixels
        pixelMap.setPixel(1, 2, 100, 150, 200);
        pixelMap.setPixel(3, 4, 50, 75, 100);
        pixelMap.setPixel(5, 6, 250, 200, 150);
        
        // Verify the first pixel
        (uint8 r1, uint8 g1, uint8 b1) = pixelMap.readPixel(1, 2);
        assertEq(r1, 100);
        assertEq(g1, 150);
        assertEq(b1, 200);
        
        // Verify the second pixel
        (uint8 r2, uint8 g2, uint8 b2) = pixelMap.readPixel(3, 4);
        assertEq(r2, 50);
        assertEq(g2, 75);
        assertEq(b2, 100);
        
        // Verify the third pixel
        (uint8 r3, uint8 g3, uint8 b3) = pixelMap.readPixel(5, 6);
        assertEq(r3, 250);
        assertEq(g3, 200);
        assertEq(b3, 150);
    }

    /**
     * @notice Test overwriting an existing pixel
     */
    function test_overwritePixel() public {
        // Set a pixel
        pixelMap.setPixel(5, 5, 10, 20, 30);
        
        // Verify the pixel was set
        (uint8 r1, uint8 g1, uint8 b1) = pixelMap.readPixel(5, 5);
        assertEq(r1, 10);
        assertEq(g1, 20);
        assertEq(b1, 30);
        
        // Overwrite the pixel
        pixelMap.setPixel(5, 5, 40, 50, 60);
        
        // Verify the pixel was overwritten
        (uint8 r2, uint8 g2, uint8 b2) = pixelMap.readPixel(5, 5);
        assertEq(r2, 40);
        assertEq(g2, 50);
        assertEq(b2, 60);
    }

    /**
     * @notice Test boundary conditions - X coordinate
     */
    function test_RevertWhen_InvalidXCoordinate() public {
        // Should revert since x >= width
        vm.expectRevert();
        pixelMap.setPixel(MAP_WIDTH, 5, 100, 100, 100);
    }

    /**
     * @notice Test boundary conditions - Y coordinate
     */
    function test_RevertWhen_InvalidYCoordinate() public {
        // Should revert since y >= height
        vm.expectRevert();
        pixelMap.setPixel(5, MAP_HEIGHT, 100, 100, 100);
    }

    /**
     * @notice Test boundary conditions for readPixel - X coordinate
     */
    function test_RevertWhen_ReadInvalidXCoordinate() public {
        // Should revert since x >= width
        vm.expectRevert();
        pixelMap.readPixel(MAP_WIDTH, 5);
    }

    /**
     * @notice Test boundary conditions for readPixel - Y coordinate
     */
    function test_RevertWhen_ReadInvalidYCoordinate() public {
        // Should revert since y >= height
        vm.expectRevert();
        pixelMap.readPixel(5, MAP_HEIGHT);
    }

    /**
     * @notice Test the constructor with invalid dimensions
     */
    function test_RevertWhen_ZeroWidth() public {
        vm.expectRevert();
        new PixelMap(0, 10);
    }

    /**
     * @notice Test the constructor with invalid dimensions
     */
    function test_RevertWhen_ZeroHeight() public {
        vm.expectRevert();
        new PixelMap(10, 0);
    }
}
