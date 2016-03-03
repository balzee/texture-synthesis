function window = getNeighborhoodWindow(pixel, image, windowSize)
im2 = padarray(image, [fix(windowSize/2),fix(windowSize/2)]);
  
minY = pixel(2) - fix(windowSize/2) + fix(windowSize/2);
minX = pixel(1) - fix(windowSize/2) + fix(windowSize/2);
maxY = pixel(2) + fix(windowSize/2) + fix(windowSize/2);
maxX = pixel(1) + fix(windowSize/2) + fix(windowSize/2);
window = im2(minX:maxX, minY:maxY);

end