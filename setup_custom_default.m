% This file contains and example setup_custom.m script 
% the setup_custom.m script is called from the setup.m script
% this script allow setting custom path locations

% DATA_PATH___ store the location of the input data file
% DATA_PATH___='c:\Data';
% DATA_PATH___='~/data';

%RESULT_ROOT___ specifies the path were output is sent.  This defaults to
%the local results folder.  output files can be large.  This allows storing
%output files in a location that has free space.
%RESULT_ROOT___='/misc/scratch/gfreeman/results';


% MATLAB_REMOTE_PATH___ specifies the matlab path when running tests
% remotely
% MATLAB_REMOTE_PATH___='/usr/local/packages/matlab_2010a/bin/matlab';

%testRunner is a function handle to run tests
% if the machine has multiple processors, multiple tests can be run
% simultaneously in a distributed manner.
% with the function handle you can pass parameters for the number of
% matlab processes to fork.  unix based systems are required for this
% feature.  The serial method is set by default.
%testRunner=@(paramset,events,basepath_name) testRunnerSerial(paramset,events,basepath_name);
%testRunner=@(paramset,events,basepath_name) testRunnerDistributed(paramset,events,basepath_name,processes);
