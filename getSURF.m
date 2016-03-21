function [ SURFData ] = getSURF( I )
thisIm=rgb2hsv(I);
thisIm=thisIm(:,:,3);

% SURF parameters
numSURFfeatures = 14;   % keep the strongest SURF features
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.
featureLengthSURF = numSURFfeatures * SURFsize; % length of vectorised SURF feature


% other parameters, memory pre-allocation

SURFFeatures = zeros(1, featureLengthSURF);     % pre-allocating memory for matrix containing all the SURF features


% --------------------------- SURF --------------------------------
try
    points = detectSURFFeatures(thisIm,'MetricThreshold',50);
    filteredPoints=filterFeaturesGreenPoint(I,points);
    [features, valid_points] = extractFeatures(thisIm, filteredPoints);
    strongestFeatures = features(1:numSURFfeatures, :);
    allSURFFeatures(1, :) = reshape(strongestFeatures, 1, featureLengthSURF);
catch
    ss=size(features);
    ['only ' num2str(ss(1)) 'features!']
end

SURFData = array2table(allSURFFeatures);
%theClass=robotClassifier.predictFcn(SURFData);
end

