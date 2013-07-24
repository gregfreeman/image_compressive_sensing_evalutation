function spgl1_lasso_small_parameter_runner


param1.field='delta';
param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'lasso_tfocs'};

param3.field='image';
param3.values=num2cell(1:17);


param4.field='image_options';
param4.values={{'cropsize',[128 128]}};

param5.field='lasso_lambda';
param5.values={0.01,0.05,0.15,0.25,1,5};
% param5.values={5,10,50};


paramset=[param1,param2,param3,param4,param5];

events=struct();
events.runExperiment=@Experiment;
events.loadInputData=@CSEvaluationImageGetter;
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;
events.setup_command='setup_study;';
events.startTasks = @( foldername, ntasks ) startTasksHtmlPost( foldername, ntasks, 'greg.freeman@utexas.edu' );
events.updateTask= @updateTaskHtmlPost;

testRunner(paramset,events);

function [outputImage,results]=Experiment(inputImage,params)
    [n1,n2]=size(inputImage);    
    N=n1*n2;
    M=floor(params.delta * N);
    params.residual_constraint=sqrt(M)*params.lasso_lambda;
    [outputImage,results]=CoarseFineExperiment(inputImage,params);
end
