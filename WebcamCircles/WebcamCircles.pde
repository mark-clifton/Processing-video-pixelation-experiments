/* Webcam Circle Pixelator
 * by Mark Clifton, 2012
 * mark-clifton.com
 * Processing sketch that renders live video input as a mosaic of circle-shaped pixels.
 * Free to copy, modify, or use without attribution for any purpose, commercial or non-commercial.
*/

import processing.video.*;

// Size of each cell in the grid
int pixelSize = 20;
// Number of cell columns and rows
int cols;
int rows;
// Variable to hold onto Capture object
Capture video;

void setup() {
  size(1280,720);
  background(0);
  // Measure number of columns and rows in the canvas area
  cols = width/pixelSize;
  rows = height/pixelSize;
  // Proceed if a camera is available to capture
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    video = new Capture(this,width,height,cameras[0],30);
    video.start();
  }
}

void draw() {
  // Read image from the capture
  if (video.available()) {
    video.read();
  }
  // Load image pixel array for manipulation
  video.loadPixels();
  // Begin loop for grid columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for grid rows
    for (int j = 0; j < rows; j++) {
      // Find position of the current grid cell
      int x = i*pixelSize;
      int y = j*pixelSize;
      // Measure color of the current cell in the pixel array
      color c = video.pixels[x + y*video.width];
      // Draw a shape with the measured fill color in the current cell
      fill(c);
      strokeWeight(2);
      stroke(0);
      ellipse(x,y,pixelSize,pixelSize);
    }
  }
}