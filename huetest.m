[I1, map] = imread('images/segment1.png');
rImage = I1(:,:,1);
gImage = I1(:,:,2);
bImage = I1(:,:,3);

%orange - ball
Rlow = 220;%1.0;
Rhigh = 255;%1.0;
Glow = 40;%0.4;
Ghigh = 175;%0.687;
Blow = 0;%0.0;
Bhigh = 100;%0.387;
        
rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);

oMask = uint8(rMask & gMask & bMask);

trim = 100;
oMask = uint8(bwareaopen(oMask, trim));
smooth = strel('disk', 4);
oMask = imclose(oMask, smooth);
oMask = uint8(imfill(oMask, 'holes'));

oMask = cast(oMask, class(I1));
IrMask = oMask .* I1(:,:,1);
IgMask = oMask .* I1(:,:,2);
IbMask = oMask .* I1(:,:,3);
oIrgbMask = cat(3, IrMask, IgMask, IbMask);

%yellow - goal & post
Rlow = 120;%1.0;
Rhigh = 255;%1.0;
Glow = 120;%0.4;
Ghigh = 255;%0.687;
Blow = 0;%0.0;
Bhigh = 100;%0.387;

rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);

yMask = uint8(rMask & gMask & bMask);

yMask = uint8(bwareaopen(yMask, trim));
yMask = imclose(yMask, smooth);
yMask = uint8(imfill(yMask, 'holes'));

yMask = cast(yMask, class(I1));
IrMask = yMask .* I1(:,:,1);
IgMask = yMask .* I1(:,:,2);
IbMask = yMask .* I1(:,:,3);
yIrgbMask = cat(3, IrMask, IgMask, IbMask);

%pink - post
Rlow = 180;%1.0;
Rhigh = 255;%1.0;
Glow = 20;%0.4;
Ghigh = 192;%0.687;
Blow = 130;%0.0;
Bhigh = 200;%0.387;

rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);

pMask = uint8(rMask & gMask & bMask);

pMask = uint8(bwareaopen(pMask, trim));
pMask = imclose(pMask, smooth);
pMask = uint8(imfill(pMask, 'holes'));

pMask = cast(pMask, class(I1));
IrMask = pMask .* I1(:,:,1);
IgMask = pMask .* I1(:,:,2);
IbMask = pMask .* I1(:,:,3);
pIrgbMask = cat(3, IrMask, IgMask, IbMask);

%blue - goal & post
Rlow = 220;%1.0;
Rhigh = 255;%1.0;
Glow = 40;%0.4;
Ghigh = 175;%0.687;
Blow = 0;%0.0;
Bhigh = 100;%0.387;

rMask = (rImage >= Rlow) & (rImage <= Rhigh);
gMask = (gImage >= Glow) & (gImage <= Ghigh);
bMask = (bImage >= Blow) & (bImage <= Bhigh);

bMask = uint8(rMask & gMask & bMask);

bMask = uint8(bwareaopen(bMask, trim));
bMask = imclose(bMask, smooth);
bMask = uint8(imfill(bMask, 'holes'));

bMask = cast(bMask, class(I1));
IrMask = bMask .* I1(:,:,1);
IgMask = bMask .* I1(:,:,2);
IbMask = bMask .* I1(:,:,3);
bIrgbMask = cat(3, IrMask, IgMask, IbMask);

IrgbMask = cat(4, oIrgbMask, yIrgbMask, pIrgbMask, bIrgbMask);
imshow(IrgbMask);
