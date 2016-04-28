function Iout   = cutRegion_global(I,Area,Centroid)
%#codegen
Iout=uint8(zeros(160,160,3));
[Asort,index] = sort(Area,'descend');
cutSize = 160;
translation = [0,-20]; %move up 20 pixel
if Asort(1)<1000
    x = size(I,2)/2;
    y = size(I,1)/2;
else
    index = index(1);
    
    x = Centroid(index,1);
    y = Centroid(index,2);
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
Iout(:)=I(top:bottom,left:right,1:3);
end

