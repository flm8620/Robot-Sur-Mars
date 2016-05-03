
extract_simu = zeros(size(simout,1),size(simout,2));
extract_simu(:,:) = simout(:,:);

labels=labels';
[coeff,score_allSURFFeatures] = pca(extract_simu);
a=extract_simu*coeff;
y = a - repmat(mean(a),[size(a,1),1]);
