function [ filteredPoints, left,right,top,bottom,regionImage ] = filterFeaturesGreenPoint( image,points )

% get rectagle from green point
[region,region2,regionImage] = largestGreenRegion(image);
rectangleSize=150;
translation = [0,-20]; %move up 20 pixel
x=0;y=0;
if size(region2,1)==0 && size(region2,2)==0
    x = region.Centroid(1);
    y = region.Centroid(2);
else
    x = (region.Centroid(1) * region.Area + region2.Centroid(1) * region2.Area) / (region.Area + region2.Area);
    y = (region.Centroid(2) * region.Area + region2.Centroid(2) * region2.Area) / (region.Area + region2.Area);
    
end
x=round(x); y=round(y);
left =x-rectangleSize/2 + translation(1);
right = x+rectangleSize/2 + translation(1);
top = y-rectangleSize/2 + translation(2);
bottom = y+rectangleSize/2 + translation(2);

filteredPoints=SURFPoints(); %initialize filteredPoints as a empty SURFPoints class
for i=1:length(points)
    x=points.Location(i,1);
    y=points.Location(i,2);
    if x>=left && x<=right && y>=top && y<=bottom
        filteredPoints = [filteredPoints; points(i)];
    end
end

end

