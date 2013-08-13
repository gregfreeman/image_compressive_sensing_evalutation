function cosamp_parameter_runner


param1.field='delta';
param1.values=num2cell(0.05:0.05:0.95);

param2.field='reconstruct';
param2.values= {'cosamp'};

param3.field='image';
param3.values=num2cell(1:17);

param5.field='cosamp_maxiterations';
param5.values={50};

param6.field='cosamp_K_factor';
param6.values={0.1,0.2,0.25,0.3,0.35,0.5};

param7.field='cosamp_tol';
param7.values={1e-3};


paramset=[param1,param2,param3,param5,param6,param7];

events=struct();
events.runExperiment=@CoarseFineExperiment;
events.loadInputData=@(settings) CSEvaluationImageGetter(settings);
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;
events.setup_command='setup_study;';
events.startTasks = @( foldername, ntasks ) startTasksHtmlPost( foldername, ntasks, 'greg.freeman@utexas.edu' );
events.updateTask= @updateTaskHtmlPost;

testRunner(paramset,events);

