imset = imageSet('.\MarsObjects','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
step=3;
listStep = 1:step:imset(1).Count;
%totalNumIm = sum([imset.Count]); 
totalNumIm = size(listStep,1) * numObj;
im1 = imset(1);
im1 = im1.read(1);
[sizex,sizey,sizez] = size(im1);
simin = zeros(sizex,sizey,sizez,totalNumIm);
simin = uint8(simin);
labels = zeros(numObj, totalNumIm);  
%labelsValue = [' ';' ';' ';' ';' ';' ';' '];
countValidImage = 0;
count = 0;
for no = 1:numObj
    numIm = imset(no).Count; % number of images for this object
    start = count+1; % for creating the label
         % images may be refused when it has not enough features
    %labelsValue(no) = imset(no).Description;
    %for ni = 1:numIm
    for ni = 1:3:numIm
        count = count + 1;
        thisImRGB = imset(no).read(ni);
        
        countValidImage=countValidImage+1;
        simin(:,:,:,countValidImage) = thisImRGB(:,:,:);
        
        %-----------------------------------------------------------------
        
    end
    finish = count; % for creating the label
    labels(no, start:finish) = 1;
end

setimage.signals.values = simin;
setimage.signals.dimensions = size(squeeze(simin(:,:,:,1)));
setimage.time = linspace(1,countValidImage,countValidImage)';