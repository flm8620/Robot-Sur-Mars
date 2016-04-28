%% Extract HOG and SURF features of the Freedent chewing gum on Mars image

%% Read in the image
I = imread('freedent_mars_small.jpg');
Igray = rgb2gray(I);    % convert colour image to grayscale

%% Extract HOG features. Experiment with different parameter values
[featureVector_8x8, hogVisualization_8x8] = extractHOGFeatures(Igray);

% Plot HOG features over the original image.
figure
subplot(1,2,1), imshow(Igray), hold on;
plot(hogVisualization_8x8);
subplot(1,2,2), plot(hogVisualization_8x8);

% Try a different cell size
[featureVector_32x32, hogVisualization_32x32] = extractHOGFeatures(Igray, 'CellSize',[32 32]);
figure
subplot(1,2,1), imshow(Igray), hold on;
plot(hogVisualization_32x32);
subplot(1,2,2), plot(hogVisualization_32x32);

% Compare the size of the featureVector_8x8 and featureVector _32x32

%% Extract SURF feature. 

points = detectSURFFeatures(Igray);
[features, valid_points] = extractFeatures(Igray, points);

% Display and plot 100 strongest SURF features.
figure; imshow(Igray); hold on;
plot(valid_points.selectStrongest(100),'showOrientation',true);