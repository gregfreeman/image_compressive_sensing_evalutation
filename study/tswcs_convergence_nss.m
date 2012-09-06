
load results\tswcs_convergence_runner_results_gregpc_20111019T133451\results_0001
result=results;
nIterations=length(result.iterations);
iIteration=1;
data=cell(nIterations,3);
[n1,n2]=size(results.iterations(1).image);

[data{:,1}]=result.iterations.ssim;
[data{:,2}]=result.iterations.mse;
[data{:,3}]=result.iterations.relative_error;
data=cell2mat(data);
figure(1)
subplot(2,1,1),plot(data(:,1))
subplot(2,1,2),plot(data(:,2))
ranges=[25,50,75,100,150,200,250];
nranges=numel(ranges);
iterations=300;
nmeasures=size(data,2);
meandata=zeros(nranges,iterations,nmeasures);
reference=SquareLiveImageData(1,'cropsize',[128 128]);
mse=@(image) mean((reference.image(:)-image(:)).^2);

images=cell(nIterations,1);
[images{:}]=result.iterations.image;
images=cell2mat(reshape(images,1,1,nIterations));
for irange=1:nranges
    range=ranges(irange);
    for start=1:(300-range+1)
        image=mean(images(:,:,1:(300-range+1)),3);
        meandata(irange,start,1)=ssim_index_m(reference.image,image); 
%         meandata(irange,start,2)=msssim(reference.image,image); 
        meandata(irange,start,2)=mse(image);
        meandata(irange,start,3)=norm(reference.image-image)/norm(reference.image);
    end
end
figure(2)
subplot(2,1,1),plot(meandata(:,:,1)')
subplot(2,1,2),plot(meandata(:,:,2)')
legend(int2str(ranges'))

ssim=data(:,1);
meanssim=mean(ssim);
good=ssim>meanssim;
image=mean(images(:,:,good),3);
good_ssim=ssim_index_m(reference.image,image);
good_mse=mse(image);