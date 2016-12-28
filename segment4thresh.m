%read image
[I1, map] = imread('images/segment4.png');
%split image into seperate RGB channels
rImage = I1(:,:,1);
gImage = I1(:,:,2);
bImage = I1(:,:,3);

%orange threshold (edit accordingly) - ball
Rlow = 220;%1.0;
Rhigh = 255;%1.0;
Glow = 40;%0.4;
Ghigh = 190;%0.687;
Blow = 0;%0.0;
Bhigh = 160;%0.387;
        
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

%blue threshold (edit accordingly) - goal & post
Rlow = 0;%1.0;
Rhigh = 40;%1.0;
Glow = 0;%0.4;
Ghigh = 200;%0.687;
Blow = 100;%0.0;
Bhigh = 255;%0.387;

%create seperate RGB masks from threshold above
rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);
%combine to make blue mask
bMask = uint8(rMask & gMask & bMask);

%apply corrections to the image (trim anomolous pixels, smooth edges and
%fill in holes)
bMask = uint8(bwareaopen(bMask, trim));
bMask = imclose(bMask, smooth);
bMask = uint8(imfill(bMask, 'holes'));

%convert to same type as image
bMask = cast(bMask, class(I1));
%create seperate RGB images from pointwise product
IrMask = bMask .* I1(:,:,1);
IgMask = bMask .* I1(:,:,2);
IbMask = bMask .* I1(:,:,3);
%concatenate RGB images
bIrgbMask = cat(3, IrMask, IgMask, IbMask);

%add all colour masked images
FIrgbMask = oIrgbMask+bIrgbMask;
%show original and final images
figure;
subplot(1,2,2); imshow(FIrgbMask);
subplot(1,2,1); imshow(I1);