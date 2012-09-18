function tfocs_lasso_parameter_runner


param1.field='delta';
param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'lasso_tfocs'};

param3.field='image';
param3.values=num2cell(1:17);

param5.field='lasso_lambda';
param5.values={0.01,0.05,0.1,0.5,1};


paramset=[param1,param2,param3,param5];

events=struct();
events.runExperiment=@CoarseFineExperiment;
events.loadInputData=@(settings) CSEvaluationImageGetter(settings);
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;

testRunner(paramset,events);
