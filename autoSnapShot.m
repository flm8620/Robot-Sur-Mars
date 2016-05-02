vidLow=videoinput('winvideo',1,'MJPG_320x240')
N=150;
for i=1:N
    'Low: '
    tic
    imgLow=getsnapshot(vidLow);
    toc
    beep
    fprintf('Number of image: %d/%d',i,N);  
    imwrite(imgLow,['.\MarsObjects\Ball\Ball',num2str(i) '.png'])
    toc
end