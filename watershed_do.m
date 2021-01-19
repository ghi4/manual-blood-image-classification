close all; clear; clc;
A = imread('Kasus10.jpg');
B = rgb2gray(A);
B = ~im2bw(B,graythresh(B));
B = imfill(B,'holes');

D = -bwdist(~B);
mask = imextendedmin(D,2);
D2 = imimposemin(D,mask);
Ld2 = watershed(D2);
bw = B;
bw(Ld2 == 0) = 0;

%imwrite(bw, 'bwzShedKasus10.jpg');
imshow(bw);