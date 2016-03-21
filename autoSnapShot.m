vidLow=videoinput('winvideo',1,'MJPG_320x240')
N=10;
for i=1:N
    'Low: '
    tic
    imgLow=getsnapshot(vidLow);
    toc
    beep
    fprintf('Number of image: %d/%d',i,N);  
    imwrite(imgLow,['.\BiggerObjectPredict\Glue\Glue',num2str(i) '.png'])
    toc
    pause(1.2)
end