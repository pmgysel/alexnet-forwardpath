This is a forward-path implementation of the CNN [AlexNet](http://www.cs.toronto.edu/~fritz/absps/imagenet.pdf).
Starting in the ILSVRC 2012 competition, Convolutional Neural Networks (CNNs) are the state-of-the-art algorithm for image classification and detection.
The straight-forward Matlab implementation of this CNN's forward path doesn't rely on any 3rd-party library.

## Detect images
In your Matlab console, type
```
alexNetForward
```
This will run AlexNet in forward path to detect a cat.

## Understanding Forward Propagation
There are lots of highly optimized deep learning tools out there, like Berkeley's [Caffe](caffe.berkeleyvision.org), [Torch](torch.ch) or
Alex Krizhevsky's [cuda-convnet2](https://github.com/akrizhevsky/cuda-convnet2). Those tools will help you train and test your CNNs at high speed.
However if you are new to deep learning, those tools won't help you much to understand the forward path of a CNN.

The goal of this project is to show you how forward-propagation works exactly in a quick and easy-to-understand way.

Every CNN is a concatenation of different layers. For more details about the different layers of AlexNet, please refer to my
[post](http://lepsucd.com/?p=522) on our research group's web page.


## Implementation details
The network is implemented as in the [Caffe](http://caffe.berkeleyvision.org/)
[definition](https://github.com/BVLC/caffe/blob/master/models/bvlc_reference_caffenet/deploy.prototxt).
The data between the layers is stored similar to [Matcaffe](http://caffe.berkeleyvision.org/tutorial/interfaces.html).
Each layer converts a 3d matrix (or 2d matrix for dense layers) **bottom** into the output **top**. The data between the layers is stored in
width W x height H x channels N matrices. All network parameters are stored in 4d matrices.

## Network parameters from Matcaffe
The network parameters are not included in this repository. Before running, please make sure you
download the pretrained model from Caffe's [Model Zoo](https://github.com/BVLC/caffe/tree/master/models/bvlc_reference_caffenet).
Instructions of the Caffe installation can be found [here](http://caffe.berkeleyvision.org/installation.html).
More information about Caffe's Matlab wrapper is here: [Matcaffe](http://caffe.berkeleyvision.org/tutorial/interfaces.html).
Once you downloaded the trained weights (bvlc_reference_caffenet.caffemodel) from the Model Zoo, use Matcaffe to extract the weights
as *.mat file. In your Matlab console, type:
```
caffe('init','<caffe-repo>/models/bvlc_reference_caffenet/deploy.prototxt','bvlc_reference_caffenet.caffemodel','test');
weights = caffe('get_weights');
save('alexnet-weights.mat','weights');
```
When you run AlexNet in forward path, you will be prompted to select the file with those weights.

## Resource Files
* **cat.jpg**: The detection runs on this image.
* **ilsvrc_2012_mean.mat**: The average of the ILSVRC image data base.
* **synset_words.txt**: The 1000 ILSVRC image classes.

## Citing
Please kindly cite this forward implementation of AlexNet if it helps your research:
```
Mohammad Motamedi, Philipp Gysel, Venkatesh Akella and Soheil Ghiasi, “Design Space Exploration of FPGA-Based Deep Convolutional Neural Network”, IEEE/ACM Asia-South Pacific Design Automation Conference (ASPDAC), January 2016.
```
