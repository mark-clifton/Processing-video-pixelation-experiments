/* Webcam Slash Pixelator
 * by Mark Clifton, 2012
 * mark-clifton.com
 * Processing sketch that renders live video input as a mosaic of slash-shaped pixels.
 * Free to copy, modify, or use without attribution for any purpose, commercial or non-commercial.
*/

import processing.video.*;

// Size of each cell in the grid
int pixelSize1 = 15;
int pixelSize2 = 37;
// Number of cell columns and rows
int cols;
int rows;
// Variable to hold Capture object
Capture video;

void setup() {
  size(1280,720);
  background(0);
  // Measure number of columns and rows in the canvas area
  cols = width/pixelSize1;
  rows = height/pixelSize2;
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
      int x = i*pixelSize1;
      int y = j*pixelSize2;
      // Measure color of the current cell in the pixel array
      color c = video.pixels[x + y*video.width];
      // Draw a shape with the measured fill color in the current cell
      fill(c);
      noStroke();
      beginShape();
      vertex(x+27, y);
      vertex(x+30, y);
      vertex(x+3, y+30);
      vertex(x, y+30);
      endShape(CLOSE);
    }
  }
}