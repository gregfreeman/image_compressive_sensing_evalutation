function stomp_parameter_runner


param1.field='delta';
param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'stomp'};

% param4.field='image_options';
% param4.values={{'cropsize',[128 128]}};

param3.field='image';
param3.values={1};
% param3.values=num2cell(1:17);

param5.field='StompTheshold';
param5.values={'FDR','FAR','RCL'};


paramset=[param1,param2,param3,param5];

events=struct();
events.runExperiment=@CoarseFineExperiment;
events.loadInputData=@(settings) CSEvaluationImageGetter(settings);
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;

testRunner(paramset,events);

