clc
clear
close all

I = imread('Doc.tiff');
gray_I = rgb2gray(I);

m = 101;
c = 0.025;
thresholded_img= Thres(m,c,gray_I);

% matlabs builtin adaptive thresholding
adapt = adaptthresh(gray_I,0.65);
BW = imbinarize(gray_I,adapt);


figure
subplot(1, 3, 1);              
subimage(gray_I);                
title('Grayscale image'); 
axis off; 

subplot(1, 3, 2);
subimage(thresholded_img);
title('thresholded image');
axis off; 

subplot(1, 3, 3);
subimage(BW);
title('matlab builtin thresholding');
axis off; 
