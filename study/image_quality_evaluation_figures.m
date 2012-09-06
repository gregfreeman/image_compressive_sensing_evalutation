function image_quality_evaluation_figures

set(0,'defaultaxesfontsize',12);
set(0,'DefaultLineLineWidth',1);

figure(1)
scrsz = get(0,'ScreenSize');
set(gcf,'Position',[1 150 900 350]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%% Medium Image

% %testRunnerCollectSave('results\large_image_runner_results_thwompeceutexasedu_20111115T114205')
% load results\large_image_runner_results_thwompeceutexasedu_20111115T114205\results
% load results\large_image_runner_results_thwompeceutexasedu_20111115T114205\paramset
testRunnerCollectSave('results\medium_image_runner_results_thwompeceutexasedu_20111202T163026')
load results\medium_image_runner_results_thwompeceutexasedu_20111202T163026\results
load results\medium_image_runner_results_thwompeceutexasedu_20111202T163026\paramset

% results2=results;
% paramset2=paramset;
% 
% % add cosamp
% %testRunnerCollectSave('results\large_image_runner_results_thwompeceutexasedu_20111118T154429')
% load results\large_image_runner_results_thwompeceutexasedu_20111118T154429\results
% load results\large_image_runner_results_thwompeceutexasedu_20111118T154429\paramset
% [results3,paramset3]=combineExperiment(results2,paramset2,results,paramset);
% 
% %testRunnerCollectSave('results\large_image_runner_results_thwompeceutexasedu_20111121T190605')
% load results\large_image_runner_results_thwompeceutexasedu_20111121T190605\results
% load results\large_image_runner_results_thwompeceutexasedu_20111121T190605\paramset
% [results4,paramset4]=combineExperiment(results3,paramset3,results,paramset);


% names={'StOMP','LASSO','TV','CoSAMP'};
names={'LASSO','StOMP(FAR)','StOMP(RCL)','CoSAMP'};
[resultsA, paramsetA]=meanExperimentData(results,paramset,'image', {'ms_ssim','ssim','mse','relative_error','runtime'});
[resultsA, paramsetA]=filterExperimentData(resultsA,paramsetA,'reconstruct',{'lasso_tfocs','stomp_far','stomp_rcl','cosamp'});
paramsetA=multivariateParameters(paramsetA);
%resultsA=resultsA(:,[1 3 4 2]); % order reconstruction algorithms to match smalls
%paramsetA(2).values=paramsetA(2).values([1 3 4 2]); % order reconstruction algorithms to match smalls
figure(1)
[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','ssim',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('SSIM');
set(gca,'YDir','reverse')
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_medium_ssim',1,'-depsc2')

[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','ms_ssim',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('MS-SSIM');
set(gca,'YDir','reverse')
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_medium_ms_ssim',1,'-depsc2')

[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','mse',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('MSE');
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_medium_mse',1,'-depsc2')

[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','relative_error',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('Relative Error');
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_medium_rel_error',1,'-depsc2')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%% Small Image

% % testRunnerCollectSave('results\small_image_runner_results_daisy_20111115T114220')
% % base experiment
% load results\small_image_runner_results_daisy_20111115T114220\results
% load results\small_image_runner_results_daisy_20111115T114220\paramset
% % for i=1:numel(results)
% %     results(i).mse=results(i).mse/255/255;
% % end
% results2=results;
% paramset2=paramset;
% 
% % add cosamp
% % testRunnerCollectSave('results\small_image_runner_results_daisy_20111118T160017')
% load results\small_image_runner_results_daisy_20111118T160017\results
% load results\small_image_runner_results_daisy_20111118T160017\paramset
% [results3,paramset3]=combineExperiment(results2,paramset2,results,paramset);
% 
% % add bcs_rvm
% %testRunnerCollectSave('results\small_image_runner_results_daisy_20111121T133354')
% load results\small_image_runner_results_daisy_20111121T133354\results
% load results\small_image_runner_results_daisy_20111121T133354\paramset
% [results4,paramset4]=combineExperiment(results3,paramset3,results,paramset);

% testRunnerCollectSave('results\small_image_runner_results_daisy_20111123T174757')
load results\small_image_runner_results_daisy_20111123T174757\stats
load results\small_image_runner_results_daisy_20111123T174757\paramset
results=stats;


%names={'TSWCS','StOMP','LASSO','TV','CoSAMP'};
names={'LASSO','StOMP(FAR)','StOMP(RCL)','CoSAMP','BCS-RVM','TSWCS',};
% {'lasso_tfocs','stomp_far','stomp_rcl','cosamp','bcs_rvm','tswcs'}
[resultsA, paramsetA]=filterExperimentData(results,paramset,'image',[1:7,9:17]);
[resultsA, paramsetA]=meanExperimentData(resultsA,paramsetA,'image', {'relative_error','mse','ms_ssim','ssim','runtime'});
[resultsA, paramsetA]=filterExperimentData(resultsA,paramsetA,'delta', paramsetA(1).values(1:8));
% [resultsA, paramsetA]=filterExperimentData(resultsA,paramsetA,'reconstruct',{'tswcs','stomp_rcl','lasso_tfocs','cosamp','bcs_rvm'});
[resultsA, paramsetA]=filterExperimentData(resultsA,paramsetA,'reconstruct', {'lasso_tfocs','stomp_far','stomp_rcl','cosamp','bcs_rvm','tswcs'});
%  {'lasso_tfocs','stomp_far','stomp_rcl','cosamp','tv_tfocs','bcs_rvm','tswcs'}
paramsetA=multivariateParameters(paramsetA);
[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','ssim',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('SSIM');
set(gca,'YDir','reverse')
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_small_ssim',1,'-depsc2')

[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','ms_ssim',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('MS-SSIM');
set(gca,'YDir','reverse')
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_small_ms_ssim',1,'-depsc2')

[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','mse',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('MSE');
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_small_mse',1,'-depsc2')

[matrix,x,hplot,hlegend,hxlabel,hylabel]=compareExperiment(resultsA,paramsetA,'delta','relative_error',[],[]);
hlegend=legend(names);
hxlabel=xlabel('Sample ratio');
hylabel=ylabel('Relative Error');
make_pretty(hplot{1},hxlabel,hylabel,hlegend)
outputFigure(1,'csquality_figure_small_rel_error',1,'-depsc2')


function make_pretty(hplot,hxlabel,hylabel,hlegend)
set(gca, 'FontName','Helvetica','FontSize',12 );
set(hlegend,'FontName','Helvetica','FontSize', 10);
set(hxlabel,'FontName','AvantGarde','FontSize',12);
set(hylabel,'FontName', 'AvantGarde','FontSize', 12);

markerstyles={'o','s','*','x','+','d'};

for iLine=1:numel(hplot)
    set(hplot(iLine),'Marker',markerstyles{iLine})
end


