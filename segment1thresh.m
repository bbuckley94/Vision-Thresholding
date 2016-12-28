%read image
[I1, map] = imread('images/segment1.png');
%split image into seperate RGB channels
rImage = I1(:,:,1);
gImage = I1(:,:,2);
bImage = I1(:,:,3);

%orange threshold (edit accordingly) - ball
Rlow = 220;%1.0;
Rhigh = 255;%1.0;
Glow = 40;%0.4;
Ghigh = 175;%0.687;
Blow = 0;%0.0;
Bhigh = 100;%0.387;
        
%create seperate RGB masks from threshold above
rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);
%combine to make orange mask
oMask = uint8(rMask & gMask & bMask);

%apply corrections to the image (trim anomolous pixels, smooth edges and
%fill in holes)
trim = 100;
oMask = uint8(bwareaopen(oMask, trim));
smooth = strel('disk', 4);
oMask = imclose(oMask, smooth);
oMask = uint8(imfill(oMask, 'holes'));

%convert to same type as image
oMask = cast(oMask, class(I1));
%create seperate RGB images from pointwise product
IrMask = oMask .* I1(:,:,1);
IgMask = oMask .* I1(:,:,2);
IbMask = oMask .* I1(:,:,3);
%concatenate RGB images
oIrgbMask = cat(3, IrMask, IgMask, IbMask);
%oIrgbMaskd = im2double(oIrgbMask);

%yellow threshold (edit accordingly) - goal & post
Rlow = 120;%1.0;
Rhigh = 255;%1.0;
Glow = 120;%0.4;
Ghigh = 255;%0.687;
Blow = 0;%0.0;
Bhigh = 100;%0.387;

%create seperate RGB masks from threshold above
rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);
%combine to make yellow mask
yMask = uint8(rMask & gMask & bMask);

%apply corrections to the image (trim anomolous pixels, smooth edges and
%fill in holes)
yMask = uint8(bwareaopen(yMask, trim));
yMask = imclose(yMask, smooth);
yMask = uint8(imfill(yMask, 'holes'));

%convert to same type as image
yMask = cast(yMask, class(I1));
%create seperate RGB images from pointwise product
IrMask = yMask .* I1(:,:,1);
IgMask = yMask .* I1(:,:,2);
IbMask = yMask .* I1(:,:,3);
%concatenate RGB images
yIrgbMask = cat(3, IrMask, IgMask, IbMask);
%yIrgbMaskd = im2double(yIrgbMask);

%FIrgbMask = cat(2, oIrgbMaskd, yIrgbMaskd);
%add all colour masked images
FIrgbMask = oIrgbMask+yIrgbMask;
%show original and final images
figure;
subplot(1,2,2); imshow(FIrgbMask);
subplot(1,2,1); imshow(I1);