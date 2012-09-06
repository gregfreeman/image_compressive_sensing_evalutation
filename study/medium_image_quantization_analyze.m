% [results,paramset]=loadExperiment('medium_image_quantization_runner_results_thwompeceutexasedu_20120310T165126');
% testRunnerCollectSave('results\medium_image_quantization_runner_results_thwompeceutexasedu_20120310T165126')
% load results\medium_image_quantization_runner_results_thwompeceutexasedu_20120310T165126\results
% load results\medium_image_quantization_runner_results_thwompeceutexasedu_20120310T165126\paramset
% [results,paramset]=loadExperiment('medium_image_quantization_runner_results_thwompeceutexasedu_20120322T110429');
% [results,paramset]=loadExperiment('medium_image_quantization_runner2_results_thwompeceutexasedu_20120328T115024');
[results,paramset]=loadExperiment('medium_image_quantization_runner2_results_thwompeceutexasedu_20120328T115024');
% [results,paramset]=loadExperiment('medium_image_quantization_runner3_results_thwompeceutexasedu_20120328T211931');
for i=1:numel(results)
    results(i).compression_bytes=results(i).nSamples*results(i).settings.quantizationBits/8;
end

set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;0 0.5 0.5],'DefaultAxesLineStyleOrder','-|-.|:')
set(0,'defaultaxesfontsize',16);
set(0,'DefaultLineLineWidth',2);
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','mse','relative_error','runtime'});
[resultsA, paramsetA]=filterExperimentData(resultsA, paramsetA,'quantizationType',{'cdf' , 'linear' });
paramsetA=multivariateParameters(paramsetA);
figure(1)
compareExperiment(resultsA,paramsetA,'delta',{'ssim', 'ms_ssim','mse','relative_error'},[],{'Interpreter','none'})
figure(2)
compareExperiment2(resultsA,paramsetA,'delta','compression_bytes',{'ssim', 'ms_ssim','mse','relative_error'},[],{'Interpreter','none'})
% subplot(3,1,1)
% xlabel('$\delta$','Interpreter','latex')
% subplot(3,1,2)
% xlabel('$\delta$','Interpreter','latex')
% subplot(3,1,3)
% xlabel('$\delta$','Interpreter','latex')
% set(gca,'YDir','reverse')


