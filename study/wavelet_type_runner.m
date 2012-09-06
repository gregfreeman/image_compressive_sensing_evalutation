function wavelet_type_runner


param1.field='delta';
param1.values=num2cell(0.05:0.05:1);

param2.field='reconstruct';
param2.values= {'stomp','lasso_tfocs'};

% param4.field='image_options';
% param4.values={{'cropsize',[128 128]}};

param3.field='image';
param3.values=num2cell(1:17);

% param4.field='alg';
% param4.values={'tswcs', 'Basic'};

param5.field='StompTheshold';
% param5.values={'FAR','RCL'};
param5.values={'RCL'};

param6.field='wavelet';
param6.values={'Daubechies','Symmlet'};


paramset=[param1,param2,param3,param5,param6];

events=struct();
events.runExperiment=@Experiment;
events.loadInputData=@CSEvaluationImageGetter;
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

    [outputImage,results]=CoarseFineExperiment(inputImage,params);
end
