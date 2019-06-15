function y = radsum(image)
    A = fftshift(fft2(image));

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
end