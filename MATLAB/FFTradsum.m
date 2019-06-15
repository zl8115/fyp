function y = FFTradsum(image)
%Code is adapted from DIPimage toolbox found at http://www.diplib.org/dipimage    

    % Modified code to perform a FFT and FFTShift on the image before
    % radial sum
    A = fftshift(fft2(image));
    
    lookup_size = size(A);
    lookup_M = zeros(size(A));
    M = ceil(size(A) / 2);

    % Check if we can use more symmetry properties
    if size(A, 1) == size(A, 2)
      s = size(A, 1);
      for i = 1:ceil(s/2)
        for j = i:ceil(s/2)
          m = floor(norm([i;j] - M')) + 1;
          lookup_M(i, j) = m;
          lookup_M(i, s-j+1) = m;
          lookup_M(j, i) = m;
          lookup_M(j, s-i+1) = m;
          lookup_M(s-i+1, j) = m;
          lookup_M(s-i+1, s-j+1) = m;
          lookup_M(s-j+1, i) = m;
          lookup_M(s-j+1, s-i+1) = m;
        end
      end
    else
      for i = 1:ceil(size(A, 1)/2)
        for j = 1:ceil(size(A, 2)/2)
          m = floor(norm([i;j] - M')) + 1;
          lookup_M(i, j) = m;
          lookup_M(size(A, 1)-i+1, j) = m;
          lookup_M(i, size(A, 2)-j+1) = m;
          lookup_M(size(A, 1)-i+1, size(A, 2)-j+1) = m;
        end
      end
    end

    % Store it in a way that we can use it with accumarray
    lookup_M = uint32(lookup_M(:));

    % Prepare the input and remove NaN elements
    A = A(:);
    A(isnan(A)) = 0;

    % Let Matlab perform its magic
    y = accumarray(lookup_M, A);

end