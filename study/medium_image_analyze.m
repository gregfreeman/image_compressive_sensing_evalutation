%medium_image_analyze

load results\medium_image_runner_results_thwompeceutexasedu_20111202T163026\results
load results\medium_image_runner_results_thwompeceutexasedu_20111202T163026\paramset


set(0,'defaultaxesfontsize',16);
set(0,'DefaultLineLineWidth',2);
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','mse','relative_error','runtime'});
paramsetA=multivariateParameters(paramsetA);
compareExperiment(resultsA,paramsetA,'delta',{'ssim', 'ms_ssim','mse','relative_error'},[],{'Interpreter','none'})
