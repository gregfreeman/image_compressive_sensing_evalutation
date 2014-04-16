Image Compressive Sensing Evaluation 
====================================

This code collection provides an evaluation testbed for comparing different compressive sensing algorithms

Installation
------------

The framework requires a recent version of MATLAB.  Some code uses class components that are not expected to work in octave at this time.

Download the code via git

    git clone https://github.com/gregfreeman/image_compressive_sensing_evaluation.git

Download the submodules via git

    cd image_compressive_sensing_evaluation
    git submodule init
    git submodule update

Download data files

	datafiles:  http://research-t-l1l2.s3-website-us-east-1.amazonaws.com/data/refimgs.zip 
	unzip location:  ../data/refimgs512x512/  	
	
	wget http://research-t-l1l2.s3-website-us-east-1.amazonaws.com/data/refimgs.zip
	mkdir ../data
	unzip refimgs.zip -d ../data/refimgs512x512

Build MEX files

    cd utility/libsvm/matlab
    make
    cd ../../..
    cd utility/spgl1
    spgsetup
    cd ../..
    cd utility/matlabPyrTools/MEX
    compilePyrTools
    cd ../../..


Gettings Started
----------------

Open MATLAB

run the setup script
    setup_study

run an example test script
    testRunnerTest1






