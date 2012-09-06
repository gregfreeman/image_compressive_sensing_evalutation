%mediume_image_analyze

% testRunnerCollectSave('results\medium_image_runner_results_thwompeceutexasedu_20111202T163026')
load results\medium_image_runner_results_thwompeceutexasedu_20111202T163026\results
load results\medium_image_runner_results_thwompeceutexasedu_20111202T163026\paramset


set(0,'defaultaxesfontsize',16);
set(0,'DefaultLineLineWidth',2);
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','mse','relative_error','runtime'});
paramsetA=multivariateParameters(paramsetA);
compareExperiment(resultsA,paramsetA,'delta',{'ssim', 'ms_ssim','mse','relative_error'},[],{'Interpreter','none'})
subplot(3,1,1)
xlabel('$\delta$','Interpreter','latex')
subplot(3,1,2)
xlabel('$\delta$','Interpreter','latex')
subplot(3,1,3)
xlabel('$\delta$','Interpreter','latex')
% set(gca,'YDir','reverse')