imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\BallHigh','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total
xmin=487;ymin=180;
xmax=890;ymax=564;
for i=1:totalNumIm
    thisIm = imset(1).read(i);
    img=thisIm(ymin:ymax,xmin:xmax,:);
    imwrite(img,['BallHighCut/image',num2str(i) '.jpg'])
end