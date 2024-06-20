clc
close all
clear all

img = imread('SampleImage.jpg');

img1 = imresize(img, [1024 1024]); % n = 10
img2 = imresize(img1, [256 256]); % n = 8
img3 = imresize(img2, [128 128]); % n = 7
img4 = imresize(img3, [64 64]); % n = 6
img5 = imresize(img4, [32 32]); % n = 5
img6 = imresize(img5, [16 16]); % n = 4
img7 = imresize(img6, [4 4]); % n = 2
img8 = imresize(img7, [2 2]); % n = 1

figure(1)
axis off
subplot(3, 3, 1);imshow(img, []); title('Orginal Image')
subplot(3, 3, 2);imshow(img1, []); title('Image[1024, 1024]')
subplot(3, 3, 3);imshow(img2,[]); title('Image[256, 256]') 
subplot(3, 3, 4);imshow(img3, []); title('Image[128, 128]')
subplot(3, 3, 5);imshow(img4,[]); title('Image[64, 64]')
subplot(3, 3, 6);imshow(img5, []); title('Image[32, 32]')
subplot(3, 3, 7);imshow(img6,[]); title('Image[16, 16]') 
subplot(3, 3, 8);imshow(img7, []); title('Image[4, 4]')
subplot(3, 3, 9);imshow(img8,[]); title('Image[2, 2]')


thresh = multithresh(img);
disp(['Original Threshold Value: ', num2str(thresh)]);

Max_Quantization_Level = max(img(:))

%Quantization Level Reduction to 8
thresh8 = multithresh(img, 7);
%Using Otsu's algorithm:
%1) Computes the histogram 
%2) Normalize the histogram, so it can be treated as a probability distribution 
%3) Compute the commulative sum 
%4) Compute the commulative mean
%5) Compute between-class variance: For every intensit level, 
%calculate between-class variance (The measure of how well the intensitites 
% can be seperated into classes)
%Variance (t) = [total mean intensity * P(t) - M(t)]^2 [P(t) (1 - P(t)]]
valuesMax8 = [thresh8 max(img(:))];
valuesMin8 = [min(img(:)) thresh8];
[quant8_I_Max, Index] = imquantize(img, thresh8, valuesMax8);
quant8_I_Min = valuesMin8(Index);

%Quantization Level Reduction to 4
thresh4 = multithresh(img, 3);
valuesMax4 = [thresh4 max(img(:))];
valuesMin4 = [min(img(:)) thresh4];
[quant4_I_Max, index] = imquantize(img, thresh4, valuesMax4);
quant4_I_Min = valuesMin4(index);

%Displaying
figure(2)
multi = cat(4,quant8_I_Min,quant8_I_Max,quant4_I_Min,quant4_I_Max);
montage(multi, 'Size', [2, 2]);
title('Minimum Interval Value               Maximum Interval Value')
ylabel('L = 4                                      L = 8')
