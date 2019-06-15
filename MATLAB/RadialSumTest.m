close all, clear all;

% Script to analyse the FFT effects and sharpness measures of images

% Load Image File (.mat file)
imagedir = 'ImageMat';
imagefile = 'Trial3.mat';
load(strcat(imagedir,filesep,imagefile))

% Select which imageset to use (rawImage/avrImage)
imageset = rawImage;
clear rawImage avrImage;

for i = 300:10:500
    image = rgb2gray(imageset{i});
    test = abs(radsum(image));
    plot(test/norm(test));
    xlim([0 50]);
    title(num2str(nameList(i)));
    pause(0.5)
end