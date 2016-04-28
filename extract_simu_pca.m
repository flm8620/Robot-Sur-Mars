extract_simu = zeros(22500,350);
extract_simu(:,:) = simout(1,:,:);

labels=labels';
[coeff,score_allSURFFeatures] = pca(extract_simu');
a=extract_simu'*coeff;
y = a - repmat(mean(a),[size(a,1),1]);