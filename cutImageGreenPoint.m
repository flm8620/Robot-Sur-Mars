function [ Iout ] = cutImageGreenPoint( I,cutSize )
% get rectagle from green point
[region,region2,~] = largestGreenRegion_simple(I);
translation = [0,-20]; %move up 20 pixel
x=0;y=0;

if isempty(region) % if there are no green part
    x = size(I,2)/2;
    y = size(I,1)/2;
else
    if isempty(region2) % if there is only one green part
        x = region.Centroid(1);
        y = region.Centroid(2);
    else % if there are two green parts
        x = (region.Centroid(1) * region.Area + region2.Centroid(1) * region2.Area) / (region.Area + region2.Area);
        y = (region.Centroid(2) * region.Area + region2.Centroid(2) * region2.Area) / (region.Area + region2.Area);
    end
end
x=round(x); y=round(y);
left =x-cutSize/2 + translation(1)+1;
right = x+cutSize/2 + translation(1);
top = y-cutSize/2 + translation(2)+1;
bottom = y+cutSize/2 + translation(2);

if left<1
    left = 1; right = cutSize;
end
if right>size(I,2)
    right = size(I,2);
    left = right - cutSize + 1;
end
if top < 1
    top = 1; bottom = cutSize;
end
if bottom > size(I,1)
    bottom = size(I,1);
    top = bottom - cutSize+1;
end
Iout=I(top:bottom,left:right,:);
end

