
testRunnerCollectSave('results\small_image_runner_results_daisy_20111115T114220')
load results\small_image_runner_results_daisy_20111115T114220\results
load results\small_image_runner_results_daisy_20111115T114220\paramset
set(0,'defaultaxesfontsize',16);
set(0,'DefaultLineLineWidth',2);
% for i=1:17
%     figure(i+i)
%     [results2, paramset2]=filterExperimentData(results,paramset,'image', i);
%     compareExperiment(results2,multivariateParameters(paramset2),'delta',{'ssim', 'mse','relative_error'})
% end
figure(1)
for i=1:numel(results)
    results(i).mse=results(i).mse/255/255;
end
[resultsA, paramsetA]=filterExperimentData(results,paramset,'image',[1,2,4:17]);
[resultsB, paramsetB]=meanExperimentData(resultsA,paramsetA,'image', {'relative_error','mse','ms_ssim','ssim','runtime'});
[resultsC, paramsetC]=filterExperimentData(resultsB,paramsetB,'delta', paramsetA(1).values(1:8));
paramsetD=multivariateParameters(paramsetC);
matrix=compareExperiment(resultsC,paramsetD,'delta',{'ssim', 'mse','relative_error'},[],{'Interpreter','none'});
subplot(3,1,1)
set(gca,'YDir','reverse')
