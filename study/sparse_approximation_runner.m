function sparse_approximation_runner

param1.field='delta';
param1.values=num2cell(0.05:0.05:1.0);
% param1.values={0.3};
% param1.values={0.1, 0.3};

% param2.field='reconstruct';
% param2.values= {'stomp','lasso_tfocs'};
% param2.values= {'stomp'};
% param2.values= {'bcs_gf'};
% param2.values= {'tv_l1magic'};
% param2.values= {'tv_tfocs'};

param3.field='image';
param3.values=num2cell(1:17);
% param3.values=num2cell(1:4);

param4.field='wavelet';
param4.values={'Daubechies','Symmlet'};

% param4.field='qmf';
% param4.values={spot.rwt.daubcqf(8,'min'),MakeONFilter('Symmlet',8)};



paramset=[param1, param3,param4];

events=struct();
% events.runExperiment=@FoveatedSamplingExperiment;
% events.runExperiment=@CoarseFineExperiment;
events.runExperiment=@Experiment;
% events.runExperiment=@ImageDomainExperiment;
% events.loadInputData=@(settings) FoveatedImageDataGetter(settings);
events.loadInputData=@(settings) CSEvaluationImageGetter(settings);
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;
events.setup_command='setup_study;';
events.startTasks = @( foldername, ntasks ) startTasksHtmlPost( foldername, ntasks, 'greg.freeman@utexas.edu' );
events.updateTask= @updateTaskHtmlPost;

testRunner(paramset,events);

end

function [outputImage,results]=Experiment(inputImage,params)
    switch params.wavelet
    case {'Daubechies'}
        params.qmf=spot.rwt.daubcqf(8,'min');
    case {'Symmlet'}      
        params.qmf=MakeONFilter('Symmlet',8);
    end

    [outputImage,results]=SparseApproximationExperiment(inputImage,params);
end

