%Softmax Function.
%bottom is a 2d matrix: N x 1.
%top is a 2d matrix: M x 1.
%For formula, see https://en.wikipedia.org/wiki/Softmax_function.
%Formula: top_i=(exp(bottom_i-bottom_max)/(sum_i(exp(bottom_i-bottom_max))).
function [ top ] = softmax( bottom )
    bottomMax=max(max(bottom));
    bottomSubstracted=bottom-bottomMax;
    bottomExp=exp(bottomSubstracted);
    bottomSum=sum(sum(bottomExp));
    top=bottomExp./bottomSum;
end
