function foveated_runner

param1.field='delta';
param1.values=num2cell(0.05:0.05:0.4);
% param1.values={0.3};

param2.field='reconstruct';
param2.values= {'lasso_tfocs','stomp_far','stomp_rcl','cosamp'};
% param2.values= {'lasso_tfocs'};
 
param3.field='image';
param3.values=num2cell(1:10);
% param3.values={1};

param4.field='structure';
param4.values={'FS-Reduce','FS', 'Basic'};

param5.field='StompTheshold';
% param5.values={'FAR','RCL'};
param5.values={'RCL'};

param6.field='wavelet';
% param6.values={'Daubechies','Symmlet'};
param6.values={'Symmlet'};


param7.field='foveation';
param7.values={'Larcom','Larcom_modified','Wang'};


paramset=[param1,param2,param3,param4,param5,param6,param7];

events=struct();
events.runExperiment=@Experiment;
events.loadInputData=@FoveatedImageDataGetter;
events.evaluateMetrics= @testQualityMetrics;
events.storeOutputData= @pngStoreOutputData;



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

    foveation_options=struct();
    foveation_options.numBands=20;
    foveation_options.filterHalfSize=20;
    
    [n1,n2]=size(inputImage);
    if strcmpi(params.foveation,'Larcom')
        foveation_options.cutoffMethod='Larcom';
    elseif strcmpi(params.foveation,'Larcom_modified')
        % this is a close fit to Wang method with viewDist=3
        foveation_options.cutoffMethod='Larcom';
        n=min([n1,n2]);  
        foveation_options.platSize=n/4;
        foveation_options.HPBW=n/4;
        foveation_options.minBandwidth = 0.1;
    else
        foveation_options.viewDist=3;        
    end
    params.foveation_implementation=foveateFilterBank([n1,n2],params.fovea,foveation_options);

    if strcmpi(params.structure,'FS-Reduce')
        [outputImage,results]= FoveatedSamplingReductionExperiment(inputImage,params);
    elseif strcmpi(params.structure,'FS')
        [outputImage,results]= FoveatedSamplingExperiment(inputImage,params);
    else
        [outputImage,results]= CoarseFineExperiment(inputImage,params);
    end
    % save settings to results structure
    % required to use foveation implementation in computing result metrics
    results.settings=params; 
end