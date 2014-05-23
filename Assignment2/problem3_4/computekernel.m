function[K] = computeKernel(x1, x2, kerneltype, d)
%This function computes the kernel function given two vectors(or matrices)
%x1         - 1*n vector(or m_1*n matrix) corresponding to the first datapoint(set of
%             'm_1' datapoints)
%x2         - 1*n vector(or m_2*n matrix) corresponding to the second datapoint(set of
%             'm_2' datapoints)

%kerneltype - string (one among) linear/poly/rbf.
%d          - specifies degree in case of polynomial kernel and width in
%             case of rbf kernel. Not used in case of linear kernel.

%Output
% Kernel matrix (m_1*m_2) or kernel value in case of vector inputs.


    linearK = x1 * x2';    
    if(strcmp(kerneltype, 'poly'))
       K = (linearK + 1) .^ d; 
    elseif(strcmp(kerneltype, 'rbf'))
        K1 = repmat(diag(x1 * x1'), 1, size(x2, 1));
        K2 = repmat(diag(x2 * x2'), 1, size(x1, 1));
        D = K1 + K2' - 2*linearK;
        K = exp(-D/(2*d^2));
    else
        K = linearK;
    end
end
