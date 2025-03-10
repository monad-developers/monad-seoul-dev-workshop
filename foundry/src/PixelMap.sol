// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * @title PixelMap Contract Template
 * @notice This contract allows users to create and interact with a pixel map
 * @dev Complete the implementation based on the instructions in comments
 */
contract PixelMap {
    /**
     * @notice Structure representing a single pixel with RGB values
     */
    struct Pixel {
        uint8 r;
        uint8 g;
        uint8 b;
    }

    // 2D array storing all pixels in the map
    Pixel[][] public pixelMap;

    // Dimensions of the pixel map
    uint public width;
    uint public height;

    /**
     * @notice Constructor to initialize the pixel map
     * @param _width Width of the pixel map
     * @param _height Height of the pixel map
     * @dev Initialize the pixel map with all white pixels (255, 255, 255)
     */
    constructor(uint _width, uint _height) {
        require(_width > 0 && _height > 0, "Width and height must be greater than 0");

        width = _width;
        height = _height;

        // TODO: Initialize the pixelMap array
        // 1. Create a 2D array of dimensions height x width
        // 2. Fill it with white pixels (r=255, g=255, b=255)
        // HINT: Use nested loops to iterate through the dimensions
        
        // YOUR CODE HERE
    }

    /**
     * @notice Sets the color of a specific pixel
     * @param x X-coordinate of the pixel
     * @param y Y-coordinate of the pixel
     * @param r Red component (0-255)
     * @param g Green component (0-255)
     * @param b Blue component (0-255)
     * @dev Validate coordinates before setting the pixel
     */
    function setPixel(uint x, uint y, uint8 r, uint8 g, uint8 b) public {
        // TODO: Implement the setPixel function
        // 1. Validate that x and y are within bounds
        // 2. Set the pixel at position (x,y) to the given RGB values
        
        // YOUR CODE HERE
    }

    /**
     * @notice Reads the color of a specific pixel
     * @param x X-coordinate of the pixel
     * @param y Y-coordinate of the pixel
     * @return RGB components of the pixel
     * @dev Validate coordinates before reading the pixel
     */
    function readPixel(uint x, uint y) public view returns (uint8, uint8, uint8) {
        // TODO: Implement the readPixel function
        // 1. Validate that x and y are within bounds
        // 2. Return the RGB values of the pixel at position (x,y)
        
        // YOUR CODE HERE
        
        // Replace this line with your implementation
        return (0, 0, 0);
    }
}