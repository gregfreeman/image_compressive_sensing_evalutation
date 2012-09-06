%large_image_analyze

% testRunnerCollectSave('results\tswcs_convergence_runner_results_gregpc_20111019T133451')

load results\tswcs_convergence_runner_results_gregpc_20111019T133451\results
load results\tswcs_convergence_runner_results_gregpc_20111019T133451\paramset
paramset=multivariateParameters(paramset);
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','runtime'});
paramsetA=multivariateParameters(paramsetA);
compareExperiment(results,paramset,'delta',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})
