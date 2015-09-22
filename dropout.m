%Dropout doesn't do anything in test phase.
function [ top ] = dropout( bottom )
    top = bottom;
end
