close all, clear all;

% Script to analyse the FFT effects and sharpness measures of images

% Load Image File (.mat file)
imagefile = 'Trial2.mat';
load(imagefile)

% Select which imageset to use (rawImage/avrImage)
imageset = avrImage;
clear rawImage avrImage;

% Sets the splicing range for Method 2 (1D FFT method)
delta = 20;

% Initialize sharpness measures
sharp1 = zeros(length(imageset),1);
sharp2 = zeros(length(imageset),1);

% Begin looping and estimating sharpness of image from dataset
for i = 1:length(imageset)
    image = rgb2gray(imageset{i}); % Loads image and grayscales it
    %imshow(image);
    %title(nameList(i));
    %pause(0.1);
    
    % Method 1, absolute sum of 2D FFT
    Y = fft2(image);
    sharp1(i) = sum(sum(abs(Y)));
    %{
    % Plot to show FFT2 spectrum
    imshow(mat2gray(log(abs(fftshift(abs(Y)+1)))));
    title(nameList(i));
    pause(0.1);
    %}
    
    % Method 2, absolute sum of 1D FFT (spliced and concatenated image)
    imageSplice = image(:,1:floor(size(image,2)/delta)*delta);
    imageSplice = reshape(imageSplice,[length(imageSplice(:)),1]);
    Y2 = fft(imageSplice);
    sharp2(i) = sum(abs(Y2));
end

% Plot of Image Sharpness Estimates
figure;
subplot(2,1,1);
plot(nameList,sharp1);
title('Absolute Image FFT2 Sum');
xlabel('Lens Current');
ylabel('Image Sharpness (AU)');
grid on;
grid minor;

subplot(2,1,2);
plot(nameList,sharp2);
title('Spliced Image FFT Sum');
xlabel('Lens Current');
ylabel('Image Sharpness (AU)');
grid on;
grid minor;

% Estimating the Maximum Sharpness Lens Setting
[V,I1] = max(sharp1);
[V,I2] = max(sharp2);
[V,min1] = min(sharp1);

% Plot of the highest Sharpness Image and its neighbors
figure;
for i = 1:3
    subplot(2,3,i);
    imshow(rgb2gray(imageset{I1-2+i}));
    title(num2str(nameList(I1-2+i)));
    
    subplot(2,3,3+i);
    imshow(rgb2gray(imageset{I2-2+i}));
    title(num2str(nameList(I2-2+i)));
end

% Plot of the highest Sharpness Image and its minimum
figure;

subplot(1,2,1)
image = rgb2gray(imageset{min1});
imshow(mat2gray(log(abs(fftshift(abs(fft2(image))+1)))));
title('Lowest Sharpness FFT2 Spectrum')

subplot(1,2,2)
image = rgb2gray(imageset{I1});
imshow(mat2gray(log(abs(fftshift(abs(fft2(image))+1)))));
title('Highest Sharpness FFT2 Spectrum')

% Save to list of datasets
[~,TrialName,~] = fileparts(imagefile);
eval(sprintf('%s.sharp1 = sharp1;',TrialName));
eval(sprintf('%s.sharp2 = sharp2;',TrialName));
eval(sprintf('%s.nameList = nameList;',TrialName));
eval(sprintf("save('SharpData.mat','%s','-append');",TrialName))
