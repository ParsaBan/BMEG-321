%% Lab Report 5: Image Processing of Liver

I = imread("liver_noisy_blurry.png"); %Import the image
gsAdj = imadjust(I);

MedianFilt = medfilt2(gsAdj); % Built-in salt and pepper filtering in matlab: 
%https://www.mathworks.com/help/images/noise-removal.html

figure(1)
imshow(MedianFilt); 

PSF = fspecial("gaussian",4,8);

WEIGHT = edge(MedianFilt,"sobel",.035);
se = strel("disk",1);
WEIGHT = 1-double(imdilate(WEIGHT,se));
WEIGHT([1:3 end-(0:2)],:) = 0;
WEIGHT(:,[1:3 end-(0:2)]) = 0;

[J,P] = deconvblind(MedianFilt,PSF,60,[],WEIGHT);
imshow(J)
title("Deblurred Image")

%imtool was used to manually deblur and enhance the contrast of the image
figure(2)
settings = imread("ImTool.png"); %Import the imtool settings
imshow(settings);
title("Imtool settings")
 
figure(3)
ConAdj = imread("ManCon.png"); %Import the new enhanced image
imshow(ConAdj);
title("Contrast Adjusted with Imtool")
 
figure(4)
imshowpair(I, ConAdj, "montage");
title("Comparison between Raw Image (left) and Edited Image (right)")