close all, clear all;

% Script to analyse the FFT effects and sharpness measures of images

% Load Image File (.mat file)
imagedir = 'ImageMat';
imagefile = 'Trial1.mat';
load(strcat(imagedir,filesep,imagefile))

% Select which imageset to use (rawImage/avrImage)
imageset = rawImage;
clear rawImage avrImage;

% Sets the splicing range for Method 2 (1D FFT method)
delta = 20;

% Initialize sharpness measures
sharp1 = zeros(length(imageset),1);
sharp2 = zeros(length(imageset),1);
sharp3 = zeros(length(imageset),1);
sharp4 = zeros(length(imageset),1);

% Begin looping and estimating sharpness of image from dataset
for i = 1:length(imageset)
    image = rgb2gray(imageset{i}); % Loads image and grayscales it
    %imshow(image);
    %title(nameList(i));
    %pause(0.1);
    
    % Method 1, absolute sum of 2D FFT
    tic;
    sharp1(i) = sharpmeasure(image,1);
    tSharp1(i) = toc;
    
    % Method 2, absolute sum of 1D FFT (spliced and concatenated image)
    tic
    sharp2(i) = sharpmeasure(image,2);
    tSharp2(i) = toc;
    
    % Method 3, RadialSum of FFT
    tic
    sharp3(i) = sharpmeasure(image,3);
    tSharp3(i) = toc;
    
    % Method 4, Blur estimate using Variance of Laplacian
    tic
    sharp4(i) = sharpmeasure(image,4);
    tSharp4(i) = toc;
end

% Plot of Image Sharpness Estimates
figure;
subplot(4,1,1);
plot(nameList,sharp1);
title('Absolute Image FFT2 Sum');
xlabel('Lens Current');
ylabel('Image Sharpness (AU)');
grid on;
grid minor;

subplot(4,1,2);
plot(nameList,sharp2);
title('Spliced Image FFT Sum');
xlabel('Lens Current');
ylabel('Image Sharpness (AU)');
grid on;
grid minor;

subplot(4,1,3);
plot(nameList,sharp3);
title('FFT Radial Sum');
xlabel('Lens Current');
ylabel('Image Sharpness (AU)');
grid on;
grid minor;

subplot(4,1,4);
plot(nameList,sharp4);
title('Var of Laplacian');
xlabel('Lens Current');
ylabel('Image Sharpness (AU)');
grid on;
grid minor;

% Estimating the Maximum Sharpness Lens Setting
[V,I1] = max(sharp1);
[V,I2] = max(sharp2);
[V,I3] = max(sharp3);
[V,I4] = max(sharp4);
[V,min] = min(sharp4);

% Plot of the highest Sharpness Image and its neighbors
figure;
for i = 1:3
    subplot(4,3,i);
    imshow(rgb2gray(imageset{I1-2+i}));
    title(num2str(nameList(I1-2+i)));
    
    subplot(4,3,3+i);
    imshow(rgb2gray(imageset{I2-2+i}));
    title(num2str(nameList(I2-2+i)));
    
    subplot(4,3,6+i);
    imshow(rgb2gray(imageset{I3-2+i}));
    title(num2str(nameList(I3-2+i)));
    
    subplot(4,3,9+i);
    imshow(rgb2gray(imageset{I4-2+i}));
    title(num2str(nameList(I4-2+i)));
end

% Plot of the highest Sharpness Image and its minimum
figure;

subplot(1,2,1)
image = rgb2gray(imageset{min});
imshow(mat2gray(log(abs(fftshift(abs(fft2(image))+1)))));
title('Lowest Sharpness FFT2 Spectrum')

subplot(1,2,2)
image = rgb2gray(imageset{I4});
imshow(mat2gray(log(abs(fftshift(abs(fft2(image))+1)))));
title('Highest Sharpness FFT2 Spectrum')

% Save to list of datasets
[~,TrialName,~] = fileparts(imagefile);
eval(sprintf('%s.sharp1 = sharp1;',TrialName));
eval(sprintf('%s.sharp2 = sharp2;',TrialName));
eval(sprintf('%s.sharp3 = sharp3;',TrialName));
eval(sprintf('%s.sharp4 = sharp4;',TrialName));
eval(sprintf('%s.nameList = nameList;',TrialName));
eval(sprintf("save('SharpData.mat','%s','-append');",TrialName))
