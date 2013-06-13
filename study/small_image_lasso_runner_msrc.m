function small_image_lasso_runner

param1.field='delta';
param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'lasso_tfocs','spgl1'};

param3.field='structure';
param3.values= {'unstructured','coarse_fine'};

param4.field='image';
param4.values=num2cell(1:30);

param5.field='image_options';
param5.values={{'cropsize',[128 128]}};

param6.field='image_category';
param6.values={1};

paramset=[param1,param2,param3,param4,param5,param6];

events=struct();
events.runExperiment=@Experiment;
events.loadInputData=@MSRCImageDBv2Getter;
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;
events.setup_command='setup_study;';
events.startTasks = @( foldername, ntasks ) startTasksHtmlPost( foldername, ntasks, 'greg.freeman@utexas.edu' );
events.updateTask= @updateTaskHtmlPost;



testRunner(paramset,events);
end

function [outputImage,results]=Experiment(inputImage,params)
    if strcmp(params.structure,'coarse_fine')
        [outputImage,results]=CoarseFineExperiment(inputImage,params);
    else
        [outputImage,results]=CSUnstructuredWaveletExperiment(inputImage,params);
    end
end
