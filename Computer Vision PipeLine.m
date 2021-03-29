%Clears all the currently open figures
clc; clear all; close all;
%Allows the load of the jpeg image from the MatLab folder
[filename, filepath] = uigetfile({'*.jpg', 'Select an Image'});
%Binds the variable selectedImage to the selected image
selectedImage = imread(strcat(filepath, filename));
%Adds gaussian noise to the selected image
iN = imnoise(selectedImage,'gaussian',0.1);
iB = imgaussfilt(iN);
%Converts the RGB image to HSV
rgbhsv = rgb2hsv(iB);
%Extracts the RGB channels(green)
green = rgbhsv(:,:,2);
%Applies a median filter to the green channel
g = medfilt2(green, [3 3]);
%Binarize the image(making it black and white)
BW = imbinarize(g);
%Removes any pixels under the size of 605
BW2 = bwareaopen(BW, 605);
%Finds the region properties from the binarized image
sts = regionprops(BW2, 'BoundingBox', 'Eccentricity', 'Solidity', 'Extent', 'Image');

hold on
cntr = 0;
%Fidns the size of each region property which all the stars have in common
%allowing the result to be more accurate
BW2 = bwpropfilt(BW2, 'Extent', [0, 0.45]);
BW2 = bwpropfilt(BW2, 'Eccentricity', [0, 0.8]);
BW2 = bwpropfilt(BW2, 'Solidity', [0, 0.6]);
figure; 
%Shows the selected image vs the binarized image
imshowpair(selectedImage, BW2,'montage');
%Assigns the loaction of the region properties to the binarized image
BWSBox = regionprops(BW2);

%Draws the bounding box around the stars
for k = 1 : length(BWSBox)
    bx = BWSBox(k).BoundingBox;
    rectangle('Position', [bx(1), bx(2),bx(3),bx(4)],'EdgeColor','b')
    %Counts the number of stars
    cntr = cntr+1;
end
%Displays the title with the amount of starfish on screen
title("Starfish count: " + cntr);
hold off;



