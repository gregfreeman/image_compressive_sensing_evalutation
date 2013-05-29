function medium_image_runner_one

param1.field='delta';
param1.values=num2cell(0.3);
% param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'spgl1'};
% param2.values= {'lasso_tfocs'};

% param2b=param2;
% param2b.values={'lasso_tfocs','stomp_far','stomp_rcl','cosamp','stomp','tv_tfocs'};



param3.field='image';
param3.values=num2cell(1);

% param4.field='image_options';
% param4.values={{'cropsize',[128 128]}};

param5.field='StompTheshold';
% param5.values={'FAR','RCL'};
param5.values={'RCL'};

param6.field='wavelet';
% param6.values={'Daubechies','Symmlet'};
param6.values={'Symmlet'};


paramset=[param1,param2,param3,param5,param6];
% paramset2=[param1,param2b,param3,param5,param6];
% paramset=diffExperiment(paramset2,paramset);

events=struct();
events.runExperiment=@Experiment;
events.loadInputData=@CSEvaluationImageGetter;
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;
events.setup_command='setup_study;';


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
