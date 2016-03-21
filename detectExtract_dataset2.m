%% Extract HOG and SURF features for the object dataset
%  (The part on extracting HOG features is not part of the exercise but
%   is included here as a reference.)

%% Load image data
imset = imageSet('.\BiggerObjects','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total

%% Extract features

% SURF parameters
numSURFfeatures = 16;   % keep the strongest SURF features
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.
featureLengthSURF = numSURFfeatures * SURFsize; % length of vectorised SURF feature
featureThreshold = 10;

% debug option
showFeatures = true;
fprintf('If you dont want to show images, set showFeatures = false\n');

% other parameters, memory pre-allocation
allSURFFeatures = zeros(totalNumIm, featureLengthSURF);     % pre-allocating memory for matrix containing all the SURF features
labels = zeros(numObj, totalNumIm);                         % binary matrix to store class labels

count = 0;               % yes, is 0, not 1

lastCount=0;
for no = 1:numObj
    numIm = imset(no).Count; % number of images for this object
    start = count+1; % for creating the label
    countValidImage = 0;     % images may be refused when it has not enough features
    for ni = 1:numIm
        count = count + 1;
        thisImRGB = imset(no).read(ni);
        thisImHSV=rgb2hsv(thisImRGB);
        thisImHSV_gray=thisImHSV(:,:,3);
        %         thisIm = rgb2gray(imset(no).read(ni));
        
        % --------------------------- SURF --------------------------------
        imageSize = size(thisImHSV_gray);
        imageHeight=imageSize(1);
        imageWidth=imageSize(2);
        allFeatures = detectSURFFeatures(thisImHSV_gray,'MetricThreshold',featureThreshold);
        [filteredFeatures,left,right,top,bottom,regionImage]=filterFeaturesGreenPoint(thisImRGB,allFeatures);
        [features, valid_points] = extractFeatures(thisImHSV_gray, filteredFeatures);
        
        %-----debug output------
        if showFeatures 
            imageShown_R=thisImRGB(:,:,1);
            imageShown_G=thisImRGB(:,:,2);
            imageShown_B=thisImRGB(:,:,3);
            imageShown_R(regionImage~=0)=255;
            imageShown_G(regionImage~=0)=0;
            imageShown_B(regionImage~=0)=0;
            imageShown=cat(3,imageShown_R,imageShown_G,imageShown_B);
            imshow(imageShown);hold on;
            objName = imset(no).Description;
            titleString = [objName ' ' num2str(ni) '/' num2str(numImEachObj(no))];
            if size(features,1) < numSURFfeatures %not enoughtFeatures
                beep;
                titleString = [titleString ' only ' num2str(size(features,1)) ' features!'];
                title(titleString,'color','red');
            else
                title(titleString);
            end
            plot(filteredFeatures.selectStrongest(numSURFfeatures));
            %plot rectangle
            plot([left,right,right,left,left],[top,top,bottom,bottom,top],'LineWidth',2,'Color','green');
            hold off;
            if size(features,1) < numSURFfeatures
                pause(0.5);
            else
                pause(0.1);
            end            
        end
        %------------------
        
        if size(features,1) < numSURFfeatures %not enought features, ignore this image
            continue
        end
        
        strongestFeatures = features(1:numSURFfeatures, :);
        allSURFFeatures(count, :) = reshape(strongestFeatures, 1, featureLengthSURF);
        countValidImage=countValidImage+1;
        
        %-----------------------------------------------------------------
        
    end
    finish = count; % for creating the label
    fprintf('%s\n',[num2str(countValidImage) '/' num2str(numImEachObj(no)) ' images for ' imset(no).Description]);
    labels(no, start:finish) = 1;
end

%%
SURFData = array2table(allSURFFeatures);
SURFData.objectType = getImageLabels(imset);
save SURFData SURFData  % save this here for classification with the *Classification Learner App* later
labels=labels';
save SURFDataNN allSURFFeatures labels  % save this here for classification with the *Neural Networks Toolbox* later

%%
% SURFData2=SURFData;
% toDelete = SURFData2.allSURFFeatures1==0;
% SURFData2(toDelete,:)=[];
% ballRows=SURFData2.objectType=='Ball';
% cubeRows=SURFData2.objectType=='Cube';
% glassRows=SURFData2.objectType=='Glass';
% 
% dataNN_input = SURFData2;
% dataNN_input(:,'objectType')=[];
% dataNN_input = table2array(dataNN_input);
% 
% dataNN_output =double( [ballRows,cubeRows,glassRows]);
