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

    points = detectSURFFeatures(thisIm,'MetricThreshold',50);
    filteredPoints=filterFeaturesGreenPoint(I,points);
    [features, valid_points] = extractFeatures(thisIm, filteredPoints);
    strongestFeatures = features(1:numSURFfeatures, :);
    sizefeat = size(features)
    if (sizefeat(1) < numSURFfeature)
        allSURFFeatures(1, :) = reshape(strongestFeatures, 1, featureLengthSURF);
    else
        ['only ' num2str(sizefeat(1)) 'features!']
    end

SURFData = array2table(allSURFFeatures);
%theClass=robotClassifier.predictFcn(SURFData);
end

