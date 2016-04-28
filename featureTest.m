%%
thisIm=rgb2gray(image1);
points = detectSURFFeatures(thisIm,'MetricThreshold',100);
%%
[features, valid_points] = extractFeatures(thisIm, points);
imshow(image1);hold on;
plot(points.selectStrongest(3));
%%
strongestFeatures = features(1:numSURFfeatures, :);