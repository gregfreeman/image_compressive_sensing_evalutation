
testRunnerCollectSave('results\tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20111010T115233')
load results\tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20111010T115233\results
load results\tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20111010T115233\paramset

% figure(1),compareExperiment(results,paramset,'delta',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})


[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','runtime'});
paramsetA=multivariateParameters(paramsetA);
compareExperiment(resultsA,paramsetA,'delta',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})




testRunnerCollectSave('results\tfocs_lasso_parameter_runner2_results_thwompeceutexasedu_20120209T191238')
load results\tfocs_lasso_parameter_runner2_results_thwompeceutexasedu_20120209T191238\results
load results\tfocs_lasso_parameter_runner2_results_thwompeceutexasedu_20120209T191238\paramset


paramsetA=multivariateParameters(paramset);
compareExperiment(results,paramsetA,'image',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})


%%

%tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20120210T150204

testRunnerCollectSave('results\tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20120210T150204')
load results\tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20120210T150204\results
load results\tfocs_lasso_parameter_runner_results_thwompeceutexasedu_20120210T150204\paramset


paramsetA=multivariateParameters(paramset);
compareExperiment(results,paramsetA,'image',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})

[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','runtime'});
paramsetA=multivariateParameters(paramsetA);
compareExperiment(resultsA,paramsetA,'delta',{'ssim', 'ms_ssim', 'runtime'},[],{'Interpreter','none'})

