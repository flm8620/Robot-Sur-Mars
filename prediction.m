%imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ForPrediction\BallLow','recursive');
%imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ForPrediction\CubeLow','recursive');
imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\ObjetsGreenPointToPredict\Ball','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total
%load trainedClassifier.mat;
numIm = imset(1).Count; % number of images for this object
glassCount=0;
cubeCount=0;
ballCount=0;

for i=1:numIm
    thisIm = imset(1).read(i);
    try
        oneSurf=getSURF(thisIm);
    catch
        continue
    end
    result = trainedClassifier.predictFcn(oneSurf);
    imshow(thisIm);
    if result=='Glass'
        title('Glass');
        glassCount=glassCount+1;
    elseif result=='Cube'
        title('Cube');
        cubeCount=cubeCount+1;
    elseif result=='Ball'
        title('Ball');
        ballCount=ballCount+1;
    end
    pause(0.5);
    
end
totalCount=glassCount+cubeCount+ballCount;

fprintf('glass: %f, cube: %f, ball %f',glassCount/totalCount,cubeCount/totalCount,ballCount/totalCount);