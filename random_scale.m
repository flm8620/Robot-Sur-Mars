function [ out ] = random_scale( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=0.9;b=1.5;
scale = rand(1)*(b-a)+a;

largeImg = zeros(240*2,320*2,3);
Ir = imresize(I,'scale',scale);
h=size(Ir,1);
w=size(Ir,2);
r=round((240*2-h)/2);
c=round((320*2-w)/2);
largeImg(r:r+h-1,c:c+w-1,:)=Ir;
out = largeImg(121:360,161:480,:);

end

