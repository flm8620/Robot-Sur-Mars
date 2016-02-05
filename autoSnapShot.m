vid=videoinput('winvideo',1,'MJPG_320x240')
for i=1:50
    img=getsnapshot(vid);
    beep
    imwrite(img,['Glass/image',num2str(i) '.jpg'])
    
    i
    
    pause(1);
end