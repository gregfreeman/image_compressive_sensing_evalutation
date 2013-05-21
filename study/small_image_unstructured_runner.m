function small_image_unstructured_runner

param1.field='delta';
param1.values={0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40,0.45};

param2.field='reconstruct';
% param2.values= {'tswcs','lasso_tfocs','stomp','tv_tfocs'};
% param2.values= {'lasso_tfocs','stomp_far','stomp_rcl','cosamp','tv_tfocs','bcs_rvm','tswcs'};
param2.values= {'lasso_tfocs','stomp_far','stomp_rcl','cosamp'};
% {'lasso_tfocs','stomp_far','stomp_rcl','cosamp','tv_tfocs'}

param3.field='image';
% param3.values={1,2,3};
param3.values=num2cell(1:17);

param4.field='image_options';
param4.values={{'cropsize',[128 128]}};

param5.field='StompTheshold';
param5.values={'RCL'};

param6.field='wavelet';
% param6.values={'Daubechies','Symmlet'};
param6.values={'Symmlet'};

paramset=[param1,param2,param3,param4,param5,param6];

%paramset2=[param1,param2b,param3,param4,param5,param6];
%paramset=diffExperiment(paramset2,paramset);

events=struct();
events.runExperiment=@Experiment;
events.loadInputData=@CSEvaluationImageGetter;
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
    
    if strcmp(params.reconstruct,'stomp_far')
        params.reconstruct='stomp';
        params.StompTheshold='FAR';
    end
    if strcmp(params.reconstruct,'stomp_rcl')
        params.reconstruct='stomp';
        params.StompTheshold='RCL';       
    end
    
    if strcmp(params.reconstruct(1:2),'tv')
        [outputImage,results]=ImageDomainExperiment(inputImage,params);
    else
        [outputImage,results]=CSUnstructuredWaveletExperiment(inputImage,params);
    end
end
