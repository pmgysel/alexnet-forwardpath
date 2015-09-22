%ReLU Nonlinearity: Rectified Linear Units.
%bottom is a 3d matrice (W x H x N) for convolutional layers,
%or a 2d matrice (N x 1) for dense layers.
%top is a 3d matrice (W x H x M) for convolutional layers,
%or a 2d matrice (M x 1) for dense layers.
%Formula: top=max(0,bottom).
function [ top ] = relu( bottom )
    top=max(0,bottom);
end
