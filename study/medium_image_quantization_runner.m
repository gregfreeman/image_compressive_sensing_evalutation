function medium_image_quantization_runner

param1.field='delta';
param1.values=num2cell(0.05:0.05:.5);
% param1.values=num2cell(0.3);

param2.field='reconstruct';
% param2.values= {'lasso_tfocs','stomp_far','stomp_rcl','cosamp'};
param2.values= {'lasso_tfocs'};

param3.field='image';
param3.values=num2cell(1:17);

% param4.field='image_options';
% param4.values={{'cropsize',[128 128]}};

param5.field='StompTheshold';
% param5.values={'FAR','RCL'};
param5.values={'RCL'};

param6.field='wavelet';
% param6.values={'Daubechies','Symmlet'};
param6.values={'Symmlet'};

param7.field='quantizationBits';
param7.values={4,6,8,16};
% param7.values={8};

param8.field='quantizationType';
param8.values={'cdf','linear','none'};
% param8.values={'linear','none'};



paramset=[param1,param2,param3,param5,param6,param7,param8];

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
        [outputImage,results]=CoarseFineExperiment(inputImage,params);
    end
end
