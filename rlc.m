%% Matlab code for Image Compression Using Run Length Encoding
clc;
clear;
close all;
%% Set Quantization Parameter
quantizedvalue=100;
%% Read Input Image
InputImage=imread('cameraman.tif');

[row col p]=size(InputImage);

%% Wavelet Decomposition

[LL LH HL HH]=dwt2(InputImage,'haar');
WaveletDecomposeImage=[LL,LH;HL,HH];
imshow(WaveletDecomposeImage,[]);

%% Uniform Quantzation


QuantizedImage= WaveletDecomposeImage/quantizedvalue;

QuantizedImage= round(QuantizedImage);

ImageArray=toZigzag(QuantizedImage)

%% Run Length Encoding
j=1;
a=length(ImageArray);
count=0;
for n=1:a
    b=ImageArray(n);
    if n==a
        count=count+1;
        c(j)=count;
        s(j)=ImageArray(n);
    elseif ImageArray(n)==ImageArray(n+1)
        count=count+1;
    elseif ImageArray(n)==b
        count=count+1;
        c(j)=count;
        s(j)=ImageArray(n);
        j=j+1;
        count=0;
    end
end

%% Transmission Variables c contains count s contains symbol
c;
s;


%% Calculation Bit Cost

InputBitcost=row*col*8;
InputBitcost=(InputBitcost);
c1=length(c);
s1=length(s);
OutputBitcost= (c1*8)+(s1*8);
OutputBitcost=(OutputBitcost);

%% Run Length Decoding

 g=length(s);
j=1;
l=1;
for i=1:g
    v(l)=s(j);
    if c(j)~=0
        w=l+c(j)-1;
        for p=l:w
            v(l)=s(j);
            l=l+1;
        end
    end
    j=j+1;
end

ReconstructedImageArray=v;

%% Inverse ZigZag

ReconstructedImage=invZigzag(ReconstructedImageArray)

%% Inverse Quantization

ReconstructedImage=ReconstructedImage*quantizedvalue;


%% Wavelet Reconstruction
sX = size(ReconstructedImage);
cA1 = ReconstructedImage(1:(sX(1)/2), 1:(sX(1)/2));
cH1 = ReconstructedImage(1:(sX(1)/2), (sX(1)/2 + 1):sX(1));
cV1 = ReconstructedImage((sX(1)/2 + 1):sX(1), 1:(sX(1)/2));
cD1 = ReconstructedImage((sX(1)/2 + 1):sX(1), (sX(1)/2 + 1):sX(1));
ReconstructedImage = idwt2(cA1,cH1,cV1,cD1,'haar');

%% Visualize both Input and Reconstructed Images

subplot(1,2,1);imshow(InputImage);title('Input Image');
subplot(1,2,2);imshow(ReconstructedImage,[]);title('Reconstructed Image');

%% Calculating PSNR and MSE
InputImage=double(InputImage);
ReconstructedImage=double(ReconstructedImage);
n=size(InputImage);
M=n(1);
N=n(2);
MSE = sum(sum((InputImage-ReconstructedImage).^2))/(M*N);
PSNR = 10*log10(256*256/MSE);
disp('MSE');
disp(MSE);
disp('PSNR');
disp(PSNR);
disp('InputBitcost');
disp(InputBitcost);
disp('OutputBitcost');
disp(OutputBitcost);

