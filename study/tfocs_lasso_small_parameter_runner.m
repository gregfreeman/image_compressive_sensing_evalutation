function tfocs_lasso_parameter_runner


param1.field='delta';
param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'lasso_tfocs'};

param3.field='image';
param3.values=num2cell(1:17);


param4.field='image_options';
param4.values={{'cropsize',[128 128]}};

param5.field='lasso_lambda';
param5.values={0.01,0.05,0.1,0.5,1,5,10,50};
% param5.values={5,10,50};


paramset=[param1,param2,param3,param4,param5];

events=struct();
events.runExperiment=@CoarseFineExperiment;
events.loadInputData=@(settings) CSEvaluationImageGetter(settings);
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;
events.setup_command='setup_study;';
events.startTasks = @( foldername, ntasks ) startTasksHtmlPost( foldername, ntasks, 'greg.freeman@utexas.edu' );
events.updateTask= @updateTaskHtmlPost;

testRunner(paramset,events);

