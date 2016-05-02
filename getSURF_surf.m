
function [ SURFData ] = getSURF_surf( I,step)
thisIm=I(:,:,1);
step=16;
% SURF parameters
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.

% --------------------------- SURF --------------------------------
thisImSize = size(thisIm);
[X,Y] = meshgrid(step/2+0.5:step:thisImSize(1),step/2+0.5:step:thisImSize(2));
points = SURFPoints([Y(:),X(:)]);
if mod(step,2)==0
    step=step-1;
end
[features1, ~] = extractFeatures(thisIm(:,:), points,'Method','Block','BlockSize',step);
%[features2, ~] = extractFeatures(thisIm(:,:,2), points,'Method','Block','BlockSize',step);
%[features3, ~] = extractFeatures(thisIm(:,:,3), points,'Method','Block','BlockSize',step);
%SURFData = [features1(:)',features2(:)',features3(:)'];
SURFData = features1(:)';
%imshow(I);hold on;
%plot(points);


end

