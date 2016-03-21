%% Extract BoFfeatures for the object dataset

%% Load image data
imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ObjetsMix','recursive');
%imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ObjetsHighCut','recursive');

%% Pre-process Training Data: *Feature Extraction*
% Requires: Computer Vision System Toolbox

% Create a bag-of-features from the Car image database
bag = bagOfFeatures(imset,'Verbose',true, 'VocabularySize',80,'PointSelection','Detector');

% Define a feature extractor function
featureExtractor = @(img) encode(bag,img);

%% Encode the images as new features
imagefeatures = featureExtractor(imset);

% Create a Table using the encoded features
BoFData              = array2table(imagefeatures);
BoFData.objectType   = getImageLabels(imset);

save BoFData BoFData


