%Softmax Function.
%bottom is a 2d matrix: N x 1.
%top is a 2d matrix: M x 1.
%For formula, see https://en.wikipedia.org/wiki/Softmax_function.
%Formula: top_i=(exp(bottom_i-bottom_max)/(sum_i(exp(bottom_i-bottom_max))).
function [ top ] = softmax( bottom )
    bottomExp=exp(bottom-max(bottom(:)));
    top=bottomExp./sum(bottomExp(:));
end
