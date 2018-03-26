function x = fit_len(x, len, dim)
% FIT_LEN - For a matrix, adjust the length along specified dimension to a
% desired value. Depending on the matrix size and desired length, the original
% matrix is either shortened or zero-padded.
% 
% Usage:
%   y = FIT_LEN(x, len, [dim])
% 
% Input:
%   x       Matrix of dimension 1 or 2
%   len     Desired size along dimension dim
%   dim     Dimension to adjust (1 or 2). Default: 1

% Torben Wendt
% 2017-11-23

if nargin < 3
    dim = 1;
end

if ~ismatrix(x) && all(dim ~= [1, 2])
    error('Sorry, only dim = 1 or dim = 2 supported.');
end

xlen = size(x, dim);

if xlen > len
    if dim == 1
        x = x(1:len, :);
    else
        x = x(:, 1:len);
    end
else
    if dim == 1
        x = [x; zeros(len - xlen, size(x, 2))];
    else
        x = [x, zeros(size(x, 1), len - xlen)];
    end
end
        