%% Create a histogram for the Freedent chewing gum object on Mars

%% Read in the image
I = imread('freedent_mars_small.jpg');
Igray = rgb2gray(I);    % convert colour image to grayscale
figure, imshow(Igray)

%% Segment out the Mars background, and the green spot.
%  This allows us to find area corresponding to the object.
BW_mars = segment_mars(I);
BW_greenSpot = segment_greenSpot(I);
BW_object = imcomplement(BW_mars | BW_greenSpot);

%% Do some post-processing to clean up the image
%  Remove areas with fewer than minNumPixels pixels
minNumPixels = 500;
BW_object = bwareaopen(BW_object, minNumPixels);  
figure, imshow(BW_object)

% Some morphological processing if we want to further clean up the image
% SE = strel('disk', 7);
% BW_object = imopen(BW_object, SE);   % opening removes small elements
% imshow(BW_object)
% BW_object = imclose(BW_object, SE); % closing fills gaps
% imshow(BW_object)

%% Now we can use the mask to isolate the foreground
Igray_object = uint8(BW_object) .* Igray ;
figure, imshow(Igray_object)

%% Make a histogram
Igray_object_vec = Igray_object(:);   % vectorise image
validValues = Igray_object_vec(Igray_object_vec > 0); % only take nonzero values
figure
edges = 0:8:255;
histogram(validValues, edges), title('Signature of the Freedent chewing gum container')
% You can play with the parameters of the histogram function, e.g. changing
% the edges, the number of bins etc.