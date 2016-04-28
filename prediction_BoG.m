imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ForPrediction\GlassDict','recursive');
%imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ForPrediction\CubeHigh','recursive');
%imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ForPrediction\GlassHigh','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total
%load trainedClassifierBoF.mat;
numIm = imset(1).Count; % number of images for this object
glassCount=0;
cubeCount=0;
ballCount=0;

for i=1:numIm
    thisIm = imset(1).read(i);
    imagefeatures=encode(bag,thisIm);
    imagefeatures = array2table(imagefeatures);
    result = trainedClassifierBoF.predictFcn(imagefeatures);
    imshow(thisIm);
    if result=='Glass' || result=='GlassHighCut'
        title('Glass');
        glassCount=glassCount+1;
    elseif result=='Cube' || result=='CubeHighCut'
        title('Cube');
        cubeCount=cubeCount+1;
    elseif result=='Ball' || result=='BallHighCut'
        title('Ball');
        ballCount=ballCount+1;
    end
    pause(0.5);
    
end

totalCount=glassCount+cubeCount+ballCount;

fprintf('glass: %f, cube: %f, ball %f',glassCount/totalCount,cubeCount/totalCount,ballCount/totalCount);