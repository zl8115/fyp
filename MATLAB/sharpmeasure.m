function y = sharpmeasure(image,option)
%SHARPMEASURE Summary of this function goes here
%   Detailed explanation goes here

    if option == 1
        delta = 20;
        imageSplice = image(:,1:floor(size(image,2)/delta)*delta);
        imageSplice = reshape(imageSplice,[length(imageSplice(:)),1]);
        Y = fft(imageSplice);
        y = sum(abs(Y));
    elseif option == 2
        Y = fft2(image);
        y = sum(abs(Y),'all');
    elseif option == 3
        RadSum = FFTradsum(image);
        RadSum = real(RadSum)/norm(real(RadSum));
        y = sum(abs(RadSum));
    elseif option == 4
        kernel1 = -1*ones(3);
        kernel1(2,2) = 4;
        lapImage = conv2(double(image), kernel1, 'same');
        y = var(lapImage,[],'all');
end

