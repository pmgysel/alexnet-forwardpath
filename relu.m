%ReLU Nonlinearity: Rectified Linear Units.
%Formula: top=max(0,bottom).
function [ top ] = relu( bottom )
    top=max(0,bottom);
end
