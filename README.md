This is a forward-path implementation of the CNN [AlexNet](http://www.cs.toronto.edu/~fritz/absps/imagenet.pdf).
Starting with the [ILSVRC 2012 competition](http://www.image-net.org/challenges/LSVRC/2012/), Convolutional Neural Networks (CNNs) proved to be state-of-the-art algorithm for image classification and detection.
This straight-forward Matlab implementation of AlexNet forward path (also called CaffeNet) doesn't rely on any 3rd-party library.

## Detect images
In your Matlab console, type
```
alexNetForward
```
This will run AlexNet in forward path to detect a cat.

## Understanding Forward Propagation
There are lots of highly optimized deep learning tools out there, like Berkeley's [Caffe](caffe.berkeleyvision.org), [Theano](http://deeplearning.net/software/theano), [Torch](torch.ch) or
Google's [TensorFlow](https://www.tensorflow.org/versions/0.6.0/get_started/index.html). Those tools will help you train and test your CNNs at high speed.
However if you are new to deep learning, those tools won't help you much to understand the forward path of a CNN.

The goal of this project is to show you how forward-propagation works exactly in a quick and easy-to-understand way.

Every CNN is a concatenation of different layers. For more details about the different layers of AlexNet, please refer to my
[post](http://lepsucd.com/?p=522) on our research group's web page.


## Implementation details
The network is implemented like [Caffe's](http://caffe.berkeleyvision.org/)
[CaffeNet](https://github.com/BVLC/caffe/blob/master/models/bvlc_reference_caffenet/deploy.prototxt) definition.
The data between the layers is stored similar to [Matcaffe](http://caffe.berkeleyvision.org/tutorial/interfaces.html).
Each layer converts a 3d matrix (or 2d matrix for dense layers) **bottom** into the output **top**. The data between the layers is stored in
width W x height H x channels N matrices. All network parameters are stored in 4d matrices.

## Network parameters from Matcaffe
The network parameters are not included in this repository. Before running, please make sure you
have the parameters of the trained network available. You can 
download the pretrained model from Caffe's [Model Zoo](https://github.com/BVLC/caffe/tree/master/models/bvlc_reference_caffenet) and use [Matcaffe](http://caffe.berkeleyvision.org/tutorial/interfaces.html)
to extract the network weights 
as *.mat file. Alternatively, you can download the weights [here](https://drive.google.com/file/d/0B-VdpVMYRh-pQWV1RWt5NHNQNnc/view).
When you run AlexNet in forward path, you will be prompted to select the MAT-file with those weights.

## Resource Files
* **cat.jpg**: The detection runs on this image.
* **ilsvrc_2012_mean.mat**: The average of the ILSVRC image data base.
* **synset_words.txt**: The 1000 ILSVRC image classes.

## Citing
Our [research group](http://lepsucd.com) is working on hardware acceleration of deep CNNs. If this project
helped your research, please kindly cite our latest conference paper:
```
Mohammad Motamedi, Philipp Gysel, Venkatesh Akella and Soheil Ghiasi, “Design Space Exploration of FPGA-Based Deep Convolutional Neural Network”, IEEE/ACM Asia-South Pacific Design Automation Conference (ASPDAC), January 2016.
```
