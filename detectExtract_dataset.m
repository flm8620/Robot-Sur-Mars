%% Extract HOG and SURF features for the object dataset
%  (The part on extracting HOG features is not part of the exercise but
%   is included here as a reference.)

%% Load image data
imset = imageSet('.\ObjetsGreenPoint','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total

%% Extract features

% SURF parameters
numSURFfeatures = 14;   % keep the strongest SURF features
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.
featureLengthSURF = numSURFfeatures * SURFsize; % length of vectorised SURF feature

% HOG parameters
cellSize = [32 32];         % HOG cell size
featureLengthHOG = 4;    % based on the image size and the function parameter values

% other parameters, memory pre-allocation
allSURFFeatures = zeros(totalNumIm, featureLengthSURF);     % pre-allocating memory for matrix containing all the SURF features
%allSURFFeatures = [];
%allHOGFeatures = zeros(totalNumIm, featureLengthHOG);       % pre-allocating memory for matrix containing all the HOG features
labels = zeros(numObj, totalNumIm);                         % binary matrix to store class labels


count = 1;
countUsed=1;
lastCount=0;
for no = 1:numObj
    numIm = imset(no).Count; % number of images for this object
    
    start = count; % for creating the label
    for ni = 1:numIm
        thisImRGB = imset(no).read(ni);
        thisIm=rgb2hsv(thisImRGB);
        thisIm=thisIm(:,:,3);
        %         thisIm = rgb2gray(imset(no).read(ni));
        % --------------------------- SURF --------------------------------
        try
            imageSize = size(thisIm);
            imageHeight=imageSize(1);
            imageWidth=imageSize(2);
            points = detectSURFFeatures(thisIm,'MetricThreshold',50);
            
            filteredPoints=filterFeaturesGreenPoint(thisImRGB,points);
            
            [features, valid_points] = extractFeatures(thisIm, filteredPoints);
            strongestFeatures = features(1:numSURFfeatures, :);
            %allSURFFeatures=[allSURFFeatures;reshape(strongestFeatures, 1, featureLengthSURF);]
            allSURFFeatures(count, :) = reshape(strongestFeatures, 1, featureLengthSURF);
            countUsed=countUsed+1;
        catch
            ss=size(features);
            ['only ' num2str(ss(1)) 'features!'];
            %imshow(thisIm);
            %pause(0.5);
            
            %figure();
%             imshow(thisIm);hold on;
%             %plot(points.selectStrongest(numSURFfeatures));
%             plot(filteredPoints.selectStrongest(numSURFfeatures));
%             pause(0.5);
        end
%         imshow(thisIm);hold on;
%         %plot(points.selectStrongest(numSURFfeatures));
%         plot(filteredPoints.selectStrongest(numSURFfeatures));
%         pause(0.5);
        %-----------------------------------------------------------------
        
        %--------------------------- HOG ---------------------------------
%         featureVector_32x32 = extractHOGFeatures(thisIm, 'CellSize', cellSize);
%         allHOGFeatures(count, :) = featureVector_32x32;
        %-----------------------------------------------------------------
        
        count = count + 1;
    end
    
    finish = countUsed - 1; % for creating the label
    [num2str(finish-lastCount) ' images for ' imset(no).Description]
    lastCount=finish;
    
    labels(no, start:finish) = 1;
end

%%
SURFData = array2table(allSURFFeatures);
SURFData.objectType = getImageLabels(imset);
%HOGData = array2table(allHOGFeatures);
%HOGData.objectType = getImageLabels(imset);
save SURFData SURFData  % save this here for classification with the *Classification Learner App* later
%save HOGData HOGData    % save this here for classification with the *Classification Learner App* later
save SURFDataNN allSURFFeatures labels  % save this here for classification with the *Neural Networks Toolbox* later
%save HOGDataNN allHOGFeatures labels    % save this here for classification with the *Neural Networks Toolbox* later

% %%
% [trainedSURFQuadSVM, validationAccuracy] = trainSURFQuad(SURFData)
% 
% save trainedSURFQuadSVM.mat trainedSURFQuadSVM;
%%
SURFData2=SURFData;
toDelete = SURFData2.allSURFFeatures1==0;
SURFData2(toDelete,:)=[];
ballRows=SURFData2.objectType=='Ball';
cubeRows=SURFData2.objectType=='Cube';
glassRows=SURFData2.objectType=='Glass';

dataNN_input = SURFData2;
dataNN_input(:,'objectType')=[];
dataNN_input = table2array(dataNN_input);

dataNN_output =double( [ballRows,cubeRows,glassRows]); 

%%
%save trainedClassifier.mat trainedClassifier;