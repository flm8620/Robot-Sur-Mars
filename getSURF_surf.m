function [ SURFData ] = getSURF_surf( I )
thisIm=rgb2hsv(I);
thisIm=thisIm(:,:,3);

% SURF parameters
numSURFfeatures = 14;   % keep the strongest SURF features
SURFsize = 64;          % default feature length. I added this here so that I could pre-allocate some memory for other variables.
featureLengthSURF = numSURFfeatures * SURFsize; % length of vectorised SURF feature


% other parameters, memory pre-allocation

SURFFeatures = zeros(1, featureLengthSURF);     % pre-allocating memory for matrix containing all the SURF features


% --------------------------- SURF --------------------------------
    thisImSize = size(thisIm);
    [X,Y] = meshgrid(4:16:thisImSize(1),4:16:thisImSize(2));
    sizex = size(X);
    sizey = size(Y);
    points = SURFPoints([reshape(Y,sizey(1)*sizey(2),1) reshape(X,sizex(1)*sizex(2),1)]);
    %points = detectSURFFeatures(thisIm,'MetricThreshold',50);
    %filteredPoints=filterFeaturesGreenPoint(I,points);
    filteredPoints = points;
    [features, valid_points] = extractFeatures(thisIm, filteredPoints);
    %sizefeat = size(features);
    %if (sizefeat(1) < numSURFfeatures)
        %strongestFeatures = features.selectStrongest(numSURFfeatures);
        %strongestFeatures = features(1:sizey(1)*numSURFfeatures,:);
        %imshow(thisIm);hold on;
        %plot(points)
        %plot(valid_points.selectStrongest(10*numSURFfeatures));
        %hold off;
    SURFData(1, :) = features(:)';
    SURFData = SURFData(1,1:100);
    %else
        %['only ' num2str(sizefeat(1)) 'features!']
    %end

%SURFData = array2table(allSURFFeatures);
%theClass=robotClassifier.predictFcn(SURFData);
end

