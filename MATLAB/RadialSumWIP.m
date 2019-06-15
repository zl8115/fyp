close all, clear all

trialName = 'Trial1';

load('SharpData.mat');
eval(sprintf('sharp1 = %s.sharp1;',trialName));
eval(sprintf('sharp2 = %s.sharp2;',trialName));
eval(sprintf('nameList = %s.nameList;',trialName));

clearvars -except trialName sharp1 sharp2 nameList

imgDir = strcat('ImageSet',filesep,trialName,filesep);

maxIdx = find(sharp1 == max(sharp1));

figure; hold on;

for k = nameList([1,maxIdx,end])

    image = rgb2gray(imread(strcat(imgDir,num2str(k),'.png')));
    Image = fftshift(fft2(image));    

    A = Image;

    lookup_size = size(A);
    lookup_M = zeros(size(A));
    M = ceil(size(A) / 2);

    for i = 1:ceil(size(A, 1)/2)
        for j = 1:ceil(size(A, 2)/2)
            m = floor(norm([i;j] - M')) + 1;
            lookup_M(i, j) = m;
            lookup_M(size(A, 1)-i+1, j) = m;
            lookup_M(i, size(A, 2)-j+1) = m;
            lookup_M(size(A, 1)-i+1, size(A, 2)-j+1) = m;
        end
    end

    lookup_M = uint32(lookup_M(:));
    % Prepare the input and remove NaN elements
    A = A(:);
    A(isnan(A)) = 0;

    % Let Matlab perform its magic
    y = accumarray(lookup_M, A);

    temp = real(y);
    plot(temp/norm(temp));
    xlim([0 20]);
    ylim([0 1]);
end