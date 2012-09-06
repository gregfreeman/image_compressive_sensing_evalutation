
testRunnerCollectSave('results\sparse_approximation_runner_results_pcgfreeman_20111115T115556')
load results\sparse_approximation_runner_results_pcgfreeman_20111115T115556\results
load results\sparse_approximation_runner_results_pcgfreeman_20111115T115556\paramset
set(0,'defaultaxesfontsize',16);
set(0,'DefaultLineLineWidth',2);
[resultsA, paramsetA]=filterExperimentData(results,paramset,'image',[1,2,4:17]);
[resultsB, paramsetB]=meanExperimentData(resultsA,paramsetA,'image', {'relative_error','mse','ms_ssim','ssim','runtime'});
[resultsC, paramsetC]=filterExperimentData(resultsB,paramsetB,'delta', paramsetA(1).values(1:8));
paramsetD=multivariateParameters(paramsetC);
matrix=compareExperiment(resultsC,paramsetD,'delta',{'ssim', 'mse','relative_error'},[],{'Interpreter','none'});
subplot(3,1,1)
set(gca,'YDir','reverse')
