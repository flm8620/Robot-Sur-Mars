
extract_simu = zeros(size(simout,2),size(simout,3));
extract_simu(:,:) = simout(1,:,:);

labels=labels';
[coeff,score_allSURFFeatures] = pca(extract_simu');
a=extract_simu'*coeff;
y = a - repmat(mean(a),[size(a,1),1]);