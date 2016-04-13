function [ largestRegion, secondLargestRegion, regionImage ] = largestGreenRegion_simple( image,Area,BoundingBox,Centroid)
mask = createMaskRGB(image);
stat = regionprops(mask,'Area','Image','BoundingBox','Centroid');
if isempty(stat) 
    largestRegion=[];
    secondLargestRegion=[];
    regionImage=[];
    return;
end

maxArea=0;
largestRegion=[];
boundingBox=[];
imageInBox=[];
n=size(stat,1);
for i = 1:n
    if maxArea<stat(i).Area
        largestRegion = stat(i);
        maxArea = stat(i).Area;
        boundingBox = stat(i).BoundingBox;
        imageInBox = stat(i).Image;
    end
end
regionImage=zeros(size(mask));
boundingBox=floor(boundingBox);
left=boundingBox(1)+1;
top=boundingBox(2)+1;
right=left + boundingBox(3)-1;
bottom=top + boundingBox(4)-1;
regionImage(top:bottom,left:right) =imageInBox;

% second largest region
mask2=mask-regionImage;
mask2=(mask2==1);
stat2 = regionprops(mask2,'Area','Image','BoundingBox','Centroid');
secondLargestRegion=[];
boundingBox=[];
imageInBox=[];
maxArea2=0;
n=size(stat2,1);
for i = 1:n
    if maxArea2<stat2(i).Area
        secondLargestRegion = stat2(i);
        maxArea2 = stat2(i).Area;
        boundingBox = stat2(i).BoundingBox;
        imageInBox = stat2(i).Image;
    end
end
if maxArea2 > 1/2*maxArea
    boundingBox=floor(boundingBox);
    left=boundingBox(1)+1;
    top=boundingBox(2)+1;
    right=left + boundingBox(3)-1;
    bottom=top + boundingBox(4)-1;
    regionImage(top:bottom,left:right) =regionImage(top:bottom,left:right)+imageInBox;
    %disp(['second detected!!!!!!!!!!!']);
end
end

