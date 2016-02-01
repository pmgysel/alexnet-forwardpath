%Forward path implementation of AlexNet
clear all;
%Load network parameters.
disp 'Weights: Choose *.mat file with AlexNet weights.'
disp 'The trained network weights can be downloaded from https://drive.google.com/file/d/0B-VdpVMYRh-pQWV1RWt5NHNQNnc/view.'
[FileName,PathName,FilterIndex] = uigetfile('./*.mat','Select the network weights');
if(~isempty(strfind(FileName,'.mat')))
	netParams=load(strcat(PathName,FileName));
    disp 'Running AlexNet in forward path. This will take about half a minute ...'
else
    error('Invalid weights selected')
end
conv1Kernels=netParams.weights(1).weights{1};
conv1Bias=netParams.weights(1).weights{2};
conv2Kernels=netParams.weights(2).weights{1};
conv2Bias=netParams.weights(2).weights{2};
conv3Kernels=netParams.weights(3).weights{1};
conv3Bias=netParams.weights(3).weights{2};
conv4Kernels=netParams.weights(4).weights{1};
conv4Bias=netParams.weights(4).weights{2};
conv5Kernels=netParams.weights(5).weights{1};
conv5Bias=netParams.weights(5).weights{2};
fc6Weights=netParams.weights(6).weights{1};
fc6Bias=netParams.weights(6).weights{2};
fc7Weights=netParams.weights(7).weights{1};
fc7Bias=netParams.weights(7).weights{2};
fc8Weights=netParams.weights(8).weights{1};
fc8Bias=netParams.weights(8).weights{2};
%Prepare input image.
%data is WxHxC major in BGR
data=prepareImage('ressources/cat.jpg');

%CNN starts here ----------------------------------------------------------
tic;
conv1=conv(data, conv1Kernels, conv1Bias, 11, 4, 0, 1);
relu1=relu(conv1);
pool1=maxpool(relu1,3,2);
lrn1=lrn(pool1,5,.0001,0.75,1);
conv2=conv(lrn1, conv2Kernels, conv2Bias, 5, 1, 2, 2);
relu2=relu(conv2);
pool2=maxpool(relu2,3,2);
norm2=lrn(pool2,5,.0001,0.75,1); 
conv3=conv(norm2, conv3Kernels, conv3Bias, 3, 1, 1, 1);
relu3=relu(conv3);
conv4=conv(relu3, conv4Kernels, conv4Bias, 3, 1, 1, 2);
relu4=relu(conv4);
conv5=conv(relu4, conv5Kernels, conv5Bias, 3, 1, 1, 2);
relu5=relu(conv5);
pool5=maxpool(relu5,3,2);
%flatten data from 3d to 1d
pool5=reshape(pool5, [9216,1]);
fc6=fc(pool5,fc6Weights,fc6Bias);
relu6=relu(fc6);
dropout6=dropout(relu6);
fc7=fc(dropout6,fc7Weights,fc7Bias);
relu7=relu(fc7);
dropout7=dropout(relu7);
fc8=fc(dropout7,fc8Weights,fc8Bias);
prob=softmax(fc8);
toc;

displayPrediction(prob);
