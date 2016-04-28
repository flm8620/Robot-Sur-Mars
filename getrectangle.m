function [left,right,top,bottom] = getrectangle(img)
region = largestGreenRegion(img);
rectanglesize=50;
left = region.Centroid(1)-rectanglesize/2;
right = region.Centroid(1)+rectanglesize/2;
top = region.Centroid(2)-rectanglesize/2 - 20;
bottom = region.Centroid(2)+rectanglesize/2 - 20;
end