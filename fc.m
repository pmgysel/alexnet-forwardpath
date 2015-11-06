%Fully Connected Layer.
%bottom is a 2d matrix: N x 1.
%top is a 2d matrix: M x 1.
%weight is a 4d matrix: 1 x 1 x N x M.
%bias is a 4d matrix: 1 x 1 x 1 x M.
%Formula: top=weights'*bottom+bias.
function [ top ] = fc( bottom, weight, bias )
    [~,~,N,M]=size(weight);
    weightFlattened=reshape(weight, [N, M]);
    biasFlattened=reshape(bias, [M, 1]);
    top=weightFlattened'*bottom+biasFlattened;
end
