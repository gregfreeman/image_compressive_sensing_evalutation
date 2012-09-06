function tswcs_convergence_runner


param1.field='delta';
param1.values=num2cell(0.05:0.10:0.25);

param2.field='reconstruct';
param2.values= {'tswcs'};

param4.field='image_options';
param4.values={{'cropsize',[128 128]}};

param3.field='image';
param3.values={1};

param5.field='save_mcmc_iterations';
param5.values={1};

param6.field='save_wavelet_data';
param6.values={1};

paramset=[param1,param2,param3,param4,param5,param6];

events=struct();
events.runExperiment=@CoarseFineExperiment;
events.getImage=@(settings) CSEvaluationImageGetter(settings);
events.evaluateMetrics= @testQualityMetricsAndNss;

% testRunnerDistributed(paramset,events,[],4);
testRunner(paramset,events);


end
function oresults=testQualityMetricsAndNss(results,inputImage,outputImage)
    oresults=testQualityMetrics(results,inputImage,outputImage);
    [n1,n2]=size(inputImage);

    nIterations=length(results.fine.iterations);

    alpha_CS = zeros(n1*n2,1);
    alpha_CS(~results.vfine)=results.coarse_samples;

    nBurnin=length(results.fine.burnin_samples);        
    for iIteration=1:nBurnin
        alpha_CS(results.vfine)= results.fine.burnin_samples{iIteration};
        outputImage2 = results.mat(results.W_op'*alpha_CS);
        result=testQualityMetrics(results,inputImage,outputImage2);
        oresults.iterations(iIteration).ssim=result.ssim;
        oresults.iterations(iIteration).mse=result.mse;
        oresults.iterations(iIteration).relative_error=result.relative_error;
        oresults.iterations(iIteration).image=outputImage2;

    end
    for iIteration=1:nIterations
        alpha_CS(results.vfine)= results.fine.iterations(iIteration).theta;
        outputImage2 = results.mat(results.W_op'*alpha_CS);
        result=testQualityMetrics(results,inputImage,outputImage2);
        oresults.iterations(iIteration+nBurnin).ssim=result.ssim;
        oresults.iterations(iIteration+nBurnin).mse=result.mse;
        oresults.iterations(iIteration+nBurnin).relative_error=result.relative_error;
        oresults.iterations(iIteration+nBurnin).image=outputImage2;
    end
end
