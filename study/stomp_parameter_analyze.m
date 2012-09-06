function stomp_parameter_analyze

testRunnerCollectSave('results\stomp_parameter_runner_results_thwomp_20111003T204542')
load results\stomp_parameter_runner_results_thwomp_20111003T204542\results
load results\stomp_parameter_runner_results_thwomp_20111003T204542\paramset
set(0,'defaultaxesfontsize',16);
set(0,'DefaultLineLineWidth',2);

showRunnerErrors(results)
% for i=1:17
%     figure(i+1)
%     [results2, paramset2]=filterExperimentData(results,paramset,'image', i);
%     compareExperiment(results2,multivariateParameters(paramset2),'delta',{'ssim', 'mse','relative_error'},[],{'Interpreter','none'})
% end
figure(1)
[results, paramset]=filterExperimentData(results,paramset,'image',[1,2,4:17]);
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'relative_error','mse','ms_ssim','ssim','runtime'});
% compareExperiment(paramsetD,resultsC,'delta',{'ssim', 'mse','relative_error'})
compareExperiment(resultsA,paramsetA,'delta',{'ssim', 'mse','relative_error'},[],{'Interpreter','none'})
