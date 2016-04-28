%% Load image data
imset = imageSet('.\BiggerObjects','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total

%% Extract features
cutSize=160;
sizeBlock = 16;
% SURF parameters
%numSURFfeatures = cutSize*cutSize/sizeBlock/sizeBlock;   % keep the strongest SURF features
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.
%featureLengthSURF = numSURFfeatures * SURFsize * 3; % length of vectorised SURF feature
featureThreshold = 10;


% -----------get feature length-------------

thisImRGB = imset(1).read(1);
imageCut = cutImageGreenPoint(thisImRGB,cutSize);
features = getSURF_surf(imageCut,sizeBlock);
% ----------end get feature length-------------  

% other parameters, memory pre-allocation
allSURFFeatures = zeros(totalNumIm, size(features(:),1));     % pre-allocating memory for matrix containing all the SURF features
labels = zeros(numObj, totalNumIm);                         % binary matrix to store class labels

count = 0;               % yes, is 0, not 1

for no = 1:numObj
    numIm = imset(no).Count; % number of images for this object
    start = count+1; % for creating the label
    countValidImage = 0;     % images may be refused when it has not enough features
    for ni = 1:numIm
        count = count + 1;
        thisImRGB = imset(no).read(ni);
        imageCut = cutImageGreenPoint(thisImRGB,cutSize);
        % --------------------------- SURF --------------------------------
        features = getSURF_surf(imageCut,sizeBlock);
        allSURFFeatures(count, :) = features(:)';
        countValidImage=countValidImage+1;
        
        %-----------------------------------------------------------------
        
    end
    finish = count; % for creating the label
    labels(no, start:finish) = 1;
end

%%
%SURFData = array2table(allSURFFeatures);
%SURFData.objectType = getImageLabels(imset);
%save SURFData SURFData  % save this here for classification with the *Classification Learner App* later
labels=labels';
[coeff,score_allSURFFeatures] = pca(allSURFFeatures);
%save SURFDataNN allSURFFeatures labels  % save this here for classification with the *Neural Networks Toolbox* later
save SURFDataNN coeff score_allSURFFeatures labels  % save this here for classification with the *Neural Networks Toolbox* later

