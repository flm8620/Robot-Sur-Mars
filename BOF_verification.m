imgSets = imageSet('.\MarsObjects','recursive');
cam=videoinput('winvideo',1,'MJPG_320x240')
N=150;
for i=1:N
    img=getsnapshot(cam);
    imshow(img);
    disp(imgSets(predict(categoryClassifier,img)).Description);
    beep    
end