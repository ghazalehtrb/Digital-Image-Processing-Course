clc
close all
clear
grayI = imread('university.tiff');
figure
imshow(grayI);
title('original image')
size = size(grayI);
h = Histo(grayI);
% plot(h)
%%
h1 = imhist(grayI);
d = h1 - h;
different_elemets = sum(abs(h1 - h));
%%
equalized_Im = HistoEq(h,grayI);
figure
imshow(uint8(equalized_Im));
J = histeq(grayI);
figure
imshow(J);
%%
J = histeq(grayI);
figure
imshow(J);
title('equalized once')
JJ = histeq(J);
figure
imshow(JJ);
title('equalized twice')

