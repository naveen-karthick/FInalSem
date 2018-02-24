function colfet=color_luv(rgb_im)
%three color moments,mean,color variance and color skewness in each channel
%(L,U and V respectively)
%total 9-D color moments
%Input image should be a rgb image,

%convert rgb to xyz colorspace
xyzTransformation = makecform('srgb2xyz');
xyzI = applycform(rgb_im,xyzTransformation);
X=xyzI(:,:,1);
Y=xyzI(:,:,2);
Z=xyzI(:,:,3);
%convert xyz to luv colorspace
warning('off');
luvTransformation = makecform('xyz2uvl');
luvI = applycform(xyzI,luvTransformation);
%disp(mean(X(:)));
%disp(mean(Y(:)));
%disp(mean(Z(:)));
%figure,imshow(luvI,'initialmagnification','fit');
%seperate l,u,v
L=luvI(:,:,1);
U=luvI(:,:,2);
V=luvI(:,:,3);
%find mean,color variance and color skewness for each channel

 colfet(1)= mean(L(:));
 colfet(2) = std(L(:))^2;
 colfet(3)= skewness(L(:));
    colfet(4) = mean(U(:));
    colfet(5) = std(U(:))^2;
    colfet(6) = skewness(U(:));
    colfet(7) = mean(V(:));
    colfet(8) = std(V(:))^2;
   colfet(9) = skewness(V(:));
%figure,imhist(X);
%figure,imhist(Y);
%figure,imhist(Z);

%disp(colfet(:));
colfet=colfet';
end
