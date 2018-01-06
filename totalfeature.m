function fet=totalfeature(rgbim)
 %color feature
 fet1=color_luv(rgbim);
%disp(fet1);
 %edge feature
 fet2=edgehist(rgbim);
%disp(fet2);
 %texture feature
 %glcm-gray level co occurrence matrix
 glcm=graycomatrix(rgb2gray(rgbim));
 fet3=glcm(:);
 %disp(fet3);
 fet=[fet1;fet2;fet3];