imset = imageSet('G:\Users\Administrator\Desktop\MathWorksProjet\Exercises\Solution\Glass','recursive');
numObj = numel(imset);              % number of different objects
numImEachObj = [imset.Count];       % number of images for each object
totalNumIm = sum([imset.Count]);    % number of images in total
xmin=84;ymin=124;
xmax=225;ymax=225;
for i=1:totalNumIm
    thisIm = rgb2gray(imset(1).read(i));
    img=thisIm(ymin:ymax,xmin:xmax);
    imwrite(img,['GlassCut/image',num2str(i) '.jpg'])
end