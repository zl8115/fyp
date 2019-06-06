close all, clear all

trialName = "Trial1";

load('SharpData.mat');
eval(sprintf('sharp1 = %s.sharp1;',trialName));
eval(sprintf('sharp2 = %s.sharp2;',trialName));
eval(sprintf('nameList = %s.nameList;',trialName));

clearvars -except trialName sharp1 sharp2 nameList

imgDir = strcat('ImageSet',filesep,trialName,filesep);

maxIdx = nameList(sharp1 == max(sharp1));
image = imread(strcat(imgDir,num2str(maxIdx),'.png'));

B = image(:,:,1);
G = image(:,:,2);
R = image(:,:,3);

figure;
subplot(1,4,1)
imshow(B)

subplot(1,4,2)
imshow(G)

subplot(1,4,3)
imshow(R)

subplot(1,4,4)
imshow(rgb2gray(image))