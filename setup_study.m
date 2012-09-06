fullpath = mfilename('fullpath');
idx      = find(fullpath == filesep);
folder = fullpath(1:(idx(end)-1));

addpath([folder '/compressive_sensed_image/structure'])
addpath([folder '/compressive_sensed_image/reconstruct'])
addpath([folder '/compressive_sensed_image/reconstruct/SparseLab/Solvers'])
addpath([folder '/compressive_sensed_image/reconstruct/SparseLab/Transforms'])
addpath([folder '/compressive_sensed_image/reconstruct/SparseLab/SharedTools'])

addpath([folder '/utility/gf_utility_toolbox'])
addpath([folder '/utility/image_quality_toolbox'])
addpath([folder '/utility/image_utility_toolbox'])
addpath([folder '/utility/spotbox'])
addpath([folder '/utility/tfocs'])
addpath([folder '/utility/rice_wavelet_toolbox'])
addpath([folder '/utility/wavelab850/Orthogonal'])
addpath([folder '/utility/gf_statistics_toolbox'])

addpath([folder '/study'])

addpath([folder '/experiment_framework'])

global EXPERIMENT_ROOT___
EXPERIMENT_ROOT___=folder;

setup_experiment_framework
