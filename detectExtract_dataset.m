%% Extract HOG and SURF features for the object dataset
%  (The part on extracting HOG features is not part of the exercise but
%   is included here as a reference.)

%% Load image data
imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\Objets','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total

%% Extract features

% SURF parameters
numSURFfeatures = 7;   % keep the strongest SURF features
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.
featureLengthSURF = numSURFfeatures * SURFsize; % length of vectorised SURF feature

% HOG parameters
cellSize = [32 32];         % HOG cell size
featureLengthHOG = 9576;    % based on the image size and the function parameter values

% other parameters, memory pre-allocation
allSURFFeatures = zeros(totalNumIm, featureLengthSURF);     % pre-allocating memory for matrix containing all the SURF features
allHOGFeatures = zeros(totalNumIm, featureLengthHOG);       % pre-allocating memory for matrix containing all the HOG features
labels = zeros(numObj, totalNumIm);                         % binary matrix to store class labels


count = 1;
for no = 1:numObj
    numIm = imset(no).Count; % number of images for this object
    
    start = count; % for creating the label
    for ni = 1:numIm
        thisIm = imset(no).read(ni);
        
        % --------------------------- SURF --------------------------------
        try
            points = detectSURFFeatures(thisIm);
            [features, valid_points] = extractFeatures(thisIm, points);
            strongestFeatures = features(1:numSURFfeatures, :);
            allSURFFeatures(count, :) = reshape(strongestFeatures, 1, featureLengthSURF);
        catch
            count=count-1;
        end
        % -----------------------------------------------------------------
        
        %         % --------------------------- HOG ---------------------------------
        %         featureVector_32x32 = extractHOGFeatures(thisIm, 'CellSize', cellSize);
        %         allHOGFeatures(count, :) = featureVector_32x32;
        %         % -----------------------------------------------------------------
        
        count = count + 1;
    end
    
    finish = count - 1; % for creating the label
    
    labels(no, start:finish) = 1;
end

%%
SURFData = array2table(allSURFFeatures);
SURFData.objectType = getImageLabels(imset);
% HOGData = array2table(allHOGFeatures);
% HOGData.objectType = getImageLabels(imset);
save SURFData SURFData  % save this here for classification with the *Classification Learner App* later
% save HOGData HOGData    % save this here for classification with the *Classification Learner App* later
save SURFDataNN allSURFFeatures labels  % save this here for classification with the *Neural Networks Toolbox* later
% save HOGDataNN allHOGFeatures labels    % save this here for classification with the *Neural Networks Toolbox* later


