
%testRunnerCollectSave('results\cosamp_parameter_runner_results_thwompeceutexasedu_20111116T123619')
load results\cosamp_parameter_runner_results_thwompeceutexasedu_20111116T123619\results
load results\cosamp_parameter_runner_results_thwompeceutexasedu_20111116T123619\paramset

% figure(1),compareExperiment(results,paramset,'delta',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})

measures={'ms_ssim','ssim','runtime','mse','relative_error'};
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', measures);
paramsetA=multivariateParameters(paramsetA);
figure(1)
[resultsB, paramsetB]=meanExperimentData(resultsA,paramsetA,'cosamp_maxiterations', measures);
[resultsB, paramsetB]=meanExperimentData(resultsB,paramsetB,'cosamp_tol', measures);
%[resultsB, paramsetB]=meanExperimentData(resultsB,paramsetB,'cosamp_K_factor', measures);
compareExperiment(resultsB,paramsetB,'delta',{'ssim', 'ms_ssim', 'mse'},[],{'Interpreter','none'})


figure(2)
[resultsB, paramsetB]=meanExperimentData(resultsA,paramsetA,'cosamp_maxiterations', measures);
%[resultsB, paramsetB]=meanExperimentData(resultsB,paramsetB,'cosamp_tol', measures);
[resultsB, paramsetB]=meanExperimentData(resultsB,paramsetB,'cosamp_K_factor', measures);
compareExperiment(resultsB,paramsetB,'delta',{'ssim', 'ms_ssim', 'mse'},[],{'Interpreter','none'})


figure(3)
%[resultsB, paramsetB]=meanExperimentData(resultsA,paramsetA,'cosamp_maxiterations', measures);
[resultsB, paramsetB]=meanExperimentData(resultsA,paramsetA,'cosamp_tol', measures);
[resultsB, paramsetB]=meanExperimentData(resultsB,paramsetB,'cosamp_K_factor', measures);
compareExperiment(resultsB,paramsetB,'delta',{'ssim', 'ms_ssim', 'mse'},[],{'Interpreter','none'})
