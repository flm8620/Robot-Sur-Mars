%% Extract BoFfeatures for the object dataset

%% Load image data
imset = imageSet('C:\Work\Clients\ENPC\StudentProject_2015\Exercises\ObjectData','recursive'); 

%% Pre-process Training Data: *Feature Extraction*
% Requires: Computer Vision System Toolbox

% Create a bag-of-features from the Car image database
bag = bagOfFeatures(imset,'Verbose',false,...
    'VocabularySize',200,'PointSelection','Detector');

% Define a feature extractor function
featureExtractor = @(img) encode(bag,img);

%% Encode the images as new features
imagefeatures = featureExtractor(imset);

% Create a Table using the encoded features
ObjectData              = array2table(imagefeatures);
ObjectData.objectType   = getImageLabels(imset);


