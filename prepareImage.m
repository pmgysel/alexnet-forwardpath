%Return an image that serves as input to AlexNet.
%fileName is the path to the image file.
%preprocessed_image is a 3d matrix with dimensions 227x227x3.
%preprocessed_image is WxHxC major in BGR.
function [ preprocessed_image ] = prepareImage( fileName )
    im = imread(fileName);
    d = load('ressources/ilsvrc_2012_mean.mat');
    mean_data = d.mean_data;
    IMAGE_DIM = 256;
    CROPPED_DIM = 227;
    % Convert an image returned by Matlab's imread to im_data in caffe's data
    % format: W x H x C with BGR channelsM = 227;
    im_data = im(:, :, [3, 2, 1]);  % permute channels from RGB to BGR
    im_data = permute(im_data, [2, 1, 3]);  % flip width and height
    im_data = single(im_data);  % convert from uint8 to single
    im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');  % resize im_data
    im_data = im_data - mean_data;  % subtract mean_data (already in W x H x C, BGR)
    im_data = imresize(im_data, [CROPPED_DIM CROPPED_DIM], 'bilinear');  % resize im_data
    preprocessed_image = zeros(CROPPED_DIM, CROPPED_DIM, 3, 'double');
    preprocessed_image(:,:,:)=im_data;
end

