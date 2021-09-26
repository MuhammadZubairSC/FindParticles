%% Finding particles on a non-uniform background
% This document outlines a simple procedure for finding particles on a
% non-uniform background.

%% The original image
originalImage= imread('image.tif');
figure
imshow(originalImage)

%% Cropping away the title bar, adding a histogram
% This image has a title bar that should be cropped away.  It is
% interesting but irrelevant that the color histogram is so close to a
% normal distribution.

croppedOriginal = imcrop(originalImage, [0 0 1024 1025]);
figure, imshow(croppedOriginal)

%% Find particles by converting image to binary
% Using Otsu's method, the threshold for a conversion to black and white is
% found.  This thrshold is very nice, but leaves a little noise to be
% cleaned up.

bwCroppedOriginal = im2bw(croppedOriginal, graythresh(croppedOriginal));
figure, imshow(bwCroppedOriginal)
   

%% Structure element used for noise removal
%  A structuring element can be created to help get rid of the noise.
%  Increasing the size of the structuring element will increase the amount
%  of noise that is rejected, possibly throwing out good particles.

se = strel('disk', 2);
openedBwCroppedOriginal = imopen(bwCroppedOriginal, se);
figure, imshow(openedBwCroppedOriginal)

%% Find the perimeters of all the particles
% This perimeters will be used for the visualization.

perimeters  = bwperim(openedBwCroppedOriginal,8);

perimiterPixelList = find(perimeters);

perimeterVisualization = croppedOriginal;
perimeterVisualization(perimiterPixelList) = 255;
load hilite %the special colormap

figure
%imview(perimeterVisualization, cmap)
imshow(perimeterVisualization)
colormap(cmap)
