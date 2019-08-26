close all, clear all;

% Script to analyse the FFT effects and sharpness measures of images

% Load Image File (.mat file)
imagedir = 'ImageMat';
imagefile = 'Trial1.mat';
load(strcat(imagedir,filesep,imagefile))

% Select which imageset to use (rawImage/avrImage)
imageset = rawImage;
clear rawImage avrImage;

maxIdx = 107;
delta = 2;
range = [maxIdx-(delta*5):delta:maxIdx];

figure; hold on;
grid on; grid minor;
xlim([1 10]);
for i = 1:length(range)
    image = rgb2gray(imageset{range(i)});
    test = abs(FFTradsum(image));
    plot(test/norm(test));    
    leg{i} = num2str(nameList(range(i)));
end
legend(leg)
xlabel('Pixel Radius (q)');
ylabel('Normalised Radial Sum');
