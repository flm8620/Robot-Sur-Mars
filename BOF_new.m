%%

imgSets = imageSet('.\MarsObjects','recursive');
%%
[trainingSets, testSets] = partition(imgSets, 0.3, 'randomize');

%bag = bagOfFeatures(trainingSets,'Verbose',true,'GridStep',[8,8],'VocabularySize',80,'PointSelection','Detector');
bag = bagOfFeatures(trainingSets,'Verbose',true,'VocabularySize',100,'PointSelection','Detector');

categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
%%
confMatrix = evaluate(categoryClassifier, testSets);

%%
testSets=imageSet('.\BiggerObjects','recursive');

%%
imset = imageSet('.\BiggerObjects','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total
%%
for no = 1:numObj
    numIm = imset(no).Count; % number of images for this object
    disp(imset(no).Description)
    for ni = 1:numIm
        img = imset(no).read(ni);
        img = imtranslate(img,[randi([-50,50]),randi([-50,50])]);
        predict(categoryClassifier,img)
    end
end

