close all; clear; clc;
A = imread('Kasus10.jpg');
B = imread('bwShedKasus10.jpg');
B = im2bw(B);

C = imageSeg2rgb(A,B);

[L,num] = bwlabel(B);
MeanR = regionprops('table',L, C(:,:,1), 'MeanIntensity');
MeanG = regionprops('table',L, C(:,:,2), 'MeanIntensity');
MeanB = regionprops('table',L, C(:,:,3), 'MeanIntensity');

FiturWarna = [MeanR.MeanIntensity MeanG.MeanIntensity MeanB.MeanIntensity];
ShapeDescp = regionprops('table',L,'Perimeter','Area','MajorAxisLength',...
    'MinorAxisLength','Centroid','Orientation');
Roundness = (ShapeDescp.Perimeter).^2./(4*pi*ShapeDescp.Area);
Ciri = [FiturWarna ShapeDescp.Area ShapeDescp.Perimeter Roundness];


indeksTrombosit = find(Ciri(:,4) < 400 & Ciri(:,6) < 1)
indeksSelDarah = find(Ciri(:,4) > 400 & Ciri(:,6) < 1.04)
indeksSelDarahAbnormal = find(Ciri(:,4) > 400 & Ciri(:,6) > 1.04 ...
    & Ciri(:,6) < 1.2)


[b,k] = size(B);
DT = zeros(b,k);
kT = length(indeksTrombosit);
for i=1:kT
    DT(find(L==(indeksTrombosit(i)))) = 1; 
end

DD = zeros(b,k);
kD = length(indeksSelDarah);
for i=1:kD
    DD(find(L==(indeksSelDarah(i)))) = 1; 
end

DDA = zeros(b,k);
kDA = length(indeksSelDarahAbnormal);
for i=1:kDA
    DDA(find(L==(indeksSelDarahAbnormal(i)))) = 1; 
end

DT = logical(DT);
DD = logical(DD);
DDA = logical(DDA);

C1 = imageSeg2rgb(A,DT);
C2 = imageSeg2rgb(A,DD);
C3 = imageSeg2rgb(A,DDA);

figure, imshow(C1), title('Trombosit');
figure, imshow(C2), title('Sel Darah Merah');
figure, imshow(C3), title('Sel Darah Abnormal');

imwrite(C1,'Trombosit.jpg');
imwrite(C2,'Sel Darah Merah.jpg');
imwrite(C3,'Sel Darah Abnormal.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Title = ['Red' 'Green' 'Blue' 'Area' 'Perimeter' 'Roundness'];
Mean = mean(Ciri(:,:));
SDev = std(Ciri(:,:));
mx = [Mean 
    SDev];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%