% % Program for Currency recognition

% Author        : Arun Kumar
% Email         : mail.drgkumar@gmail.com
% Version       : 1.0
% Date          :7/4/2014

%% clear workspace and command window
clear;clc;
%% read image
[imname,impath]=uigetfile({'*.jpg;*.png'});
im=imread([impath,'/',imname]);
%preprocessing
%resize image
im=imresize(im,[128 128]);
%remove noise;
%seperate channels
 r_channel=im(:,:,1);
 b_channel=im(:,:,2);
 g_channel=im(:,:,3);

 %denoise each channel
 r_channel=medfilt2(r_channel);
 g_channel=medfilt2(g_channel);
 b_channel=medfilt2(b_channel);
 %restore channels
 rgbim(:,:,1)=r_channel;
 rgbim(:,:,2)=g_channel;        
 rgbim(:,:,3)=b_channel;
  r_channel=rgbim(:,:,1);
 b_channel=rgbim(:,:,2);
 g_channel=rgbim(:,:,3);
 %featureextraction
fet=totalfeature(rgbim);
load db;
load jolly1;
k=length(currency);
%disp(currency(1).feature);
for j=1:k
    D(j)=dist(fet',currency(j).feature);
end
[value,index]=min(D);
new_im=rgb2ycbcr(rgbim);
y=double(new_im(:,:,1));
edim = edge(y, 'canny');
%figure,imshow(edim);


e=imfill(edim,'holes');

%figure,imshow(e),title('suma');
k1=0;
j2=-1;
figure,vislabels(e),title('labelled');
count=regionprops(e,'Eulernumber');
g=regionprops(e,'centroid');
l=regionprops(e,'Orientation');
q=regionprops(e,'Solidity');
load jolly1.mat;
n=size(g);
c1=0;
c2=0;
for j=1:5
for i=1:n
    value=0;
  s=cat(1,g(i).Centroid);
   % disp(i);
  %fprintf('x-co-ordinate');

%disp(s(1));
%fprintf('Y-co-ordinate ');
%disp(s(2));
  v=cat(1,l(i).Orientation);
%fprintf('Orientation ');
% disp(v);
 %disp(q(i));
q1=cat(1,q(i).Solidity);
  value=s(1)+s(2);
  value1=x(j,1)+x(j,2);
  value2=x(j,1)-s(1);
  value3=x(j,1)+x(j,2);
  value4=x(j,2)-s(2);
  y=x(j,3);
  if(x(j,3)<0)
      y=x(j,3)*-1;
  end
  z=v;
  if(v<-1)
      z=-v;
  end
  value5=y-z;
  value6=x(j,4)-q1(1);
 % disp(value4);
  if ((value2>-10&&value2<10)&&(value4>-10&&value4<10))&&(value5>-10&&value5<10&&value6>-0.3&&value6<0.3)
     %fprintf('suma');
     % disp(value2);
        if(j==4)
          %  disp(i);
            c1=1;
            continue;
        end
            if(j==5)
                c2=1;
            end
      j2=j;
      k1=1;
    % disp(i);
     % disp(j2);
      break;
  end
  if(k1==1)
      break;
  end

end
  if(k1==1)
      break;
  end
end
den = -1;
load Denominations;
if((c1==1&&c2==1)||(c1==1&&j2==-1)||(c2==1&&j2==-1))
    j2=-2;
    fprintf('Recognised Currency is Dollar');
end
if(j2==2||j2==3)
    den=1;
    fprintf('Recognised Currency is rupee');     
end
if(j2==1)
    fprintf('Recognised Currency is Pound');
end
if(j2==-1)
if value>0.001
   currency_name=currency(index).name;
   fprintf('recognized currency is : ');
   disp(currency_name)
else
    disp('no matches found');
end

end
values = size(denomination(den).values);
for i=1:values;
    red = mean(r_channel(:))-denomination(den).values(i,2);
    if(red<0) 
        red=red*-1;
    end
    green = mean(g_channel(:))-denomination(den).values(i,3);
    if(green<0) 
        green=green*-1;
    end
    blue = mean(b_channel(:))-denomination(den).values(i,4);
    if(blue<0) 
        blue=blue*-1;
    end
if(red<3&&blue<3&&green<3)
    disp(denomination(den).values(i,1));
end

end

    %disp(den)
    %disp(mean(r_channel(:)));
    %disp(denomination(1).values(1,2));

%disp(x(2,1));
%disp(x(2,2));
%disp(x(2,3));
%    disp(x(2,4));
    
