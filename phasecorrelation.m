%说明
%相位相关法是基于傅氏功率谱的相关技术。该方法利用
%互功率谱中的相位信息进行图像配准，对图像的亮度变换不敏感，而且
%容易获得最大相关系数


function [ff1,score,rawdis,coldis] = phasecorrelation(IS,IF)
%IS=imread('view1.bmp');      %源图像
%[k1,k2]=analysisp(IS);
%IS=rgb2gray(IS);
%IF=rgb2gray(IF);
fftIS=(fft2(im2double(IS)));   
%IF=imread('view2.bmp');      %匹配图像
fftIF=(fft2(im2double(IF)));
fftIFG=conj(fftIF);

%A=fftISG.*fftIF;
A=fftIS.*fftIFG;
if(max(max(A))==min(min(A)))
    coldis=16;
    rawdis=16;
    ff1=zeros(size(A));
    score=0;
    return 
end
AA=abs(A);
 [a,b]=find(AA==0);
   for i=1:size(a,1) 
     AA(a(i),b(i))=0.00001;
  end
PS=A./AA;
 [a,b]=find(isnan(PS)==1);
  %$PS(a,b)=0 ;
  for i=1:size(a,1) 
     PS(a(i),b(i))=1/0.00001;
  end
  %for i=1:size(a,1) 
  %   PS(a(i),b(i))=mean(mean(PS));
 % end

PS((abs(imag(PS))<10e-20)&(abs(real(PS))<10e-20)) = 1;   %nan
[c,i]=max(ifft2(PS),[],1);

[c,i]=max(ifft2(PS),[],1);
ff2=ifft2(PS);          %band-limited 
%ff1=abs(ff2);
%ff1=abs(real(ff2));
ff1=abs((ff2));
if(sum(sum(isnan(ff1)))>0)
    coldis=16;
    rawdis=16;
    
    ff1=zeros(size(ff1));
    score=0;
    return 
end
if(max(max(ff1))<abs(min(min(ff1))))
    %[coldist,rawdist]= find(ff==min(min(ff))); 
    %ff=abs(ifft2(PS));
    coldis=0;
    rawdis=0;
else
   
    [coldist,rawdist]= find(ff1==max(max(ff1)));        % calculate the displacement
     coldis=coldist;
    rawdis=rawdist;
    %figure(10)
    %mesh(ff1)
    %if((~isempty(ff1))&(~isnan(ff1)))
    %[cc]=functionfitting(ff1);                           % function fitting 
    %ff=abs(ifft2(PS));
   
    %coldis=round((coldist-1)*size(PS,1)/size(ff1,1))+1;
    %rawdis=round((rawdist-1)*size(PS,2)/size(ff1,2))+1;
   
     %coldis=cc(2);
     %%%rawdis=cc(3);
     %coldis=coldis+1;
     %rawdis=rawdis+1;    
    %end
end
ff=ff1;

if isempty(coldis)|isempty(rawdis)
    coldis=10
    rawdis=10
end
%if((coldis<=0.5*size(ff,1))&&(rawdis<=0.5*size(ff,2)))
%    coldis=floor(coldis);
%    rawdis=floor(rawdis);
%end
%if((coldis>0.5*size(ff,1))&&(rawdis<=0.5*size(ff,2))) %4 kinds of conditions 
%        %coldis=floor(coldis-1-size(ff,2));
%        %rawdis=floor(rawdis);
%        rawdis=floor(rawdis-1-size(ff,2));
%        coldis=floor(coldis);
%end
% if((coldis<=0.5*size(ff,1))&&(rawdis>0.5*size(ff,2)))
%        %coldis=floor(coldis-1);
%        %rawdis=floor(rawdis-1-size(ff,1));
%        rawdis=floor(rawdis);
%        coldis=floor(coldis-1-size(ff,1));
%end
%if((coldis>0.5*size(ff,1))&&(rawdis>0.5*size(ff,2)))
%      coldis=floor(coldis-1-size(ff,1));
%        rawdis=floor(rawdis-1-size(ff,2));
%end
if(coldist<0.5*size(ff,1))
    coldis=0-coldist
end
if(coldist>=0.5*size(ff,1))
    coldis=size(ff,1)-coldist
end
if(rawdist<0.5*size(ff,2))
    rawdis=0-rawdist
end
if(rawdist>=0.5*size(ff,2))
    rawdis=size(ff,2)-rawdist
end
%IS=[IS zeros(size(IS,1),rawdis);zeros(coldis,size(IS,2)) zeros(coldis,rawdis)];
%IF=[zeros(coldis,rawdis) zeros(coldis,size(IF,2));zeros(size(IF,1),rawdis) IF];
[k1,k2]=analysisp(IS);
fftIS=(fft2(im2double(IS)));   
%IF=imread('view2.bmp');      %匹配图像
fftIF=(fft2(im2double(IF)));
fftIFG=conj(fftIF);

%A=fftISG.*fftIF;
A=fftIS.*fftIFG;
if(max(max(A))==min(min(A)))
    coldis=8;
    rawdis=8;
    ff1=zeros(size(A));
    score=0;
    return 
end
AA=abs(A);
 [a,b]=find(AA==0);
   for i=1:size(a,1) 
     AA(a(i),b(i))=0.00001;
  end
PS=A./AA;
 [a,b]=find(isnan(PS)==1);
  %$PS(a,b)=0 ;
  for i=1:size(a,1) 
     PS(a(i),b(i))=1/0.00001;
  end
  %for i=1:size(a,1) 
  %   PS(a(i),b(i))=mean(mean(PS));
 % end

PS((abs(imag(PS))<10e-20)&(abs(real(PS))<10e-20)) = 1;   %nan
[c,i]=max(ifft2(PS),[],1);

ff1=ifft2(PS(k2,k1));
ff=abs(ff1);

%if(mod(coldis+))
sctemp=sort(max(ff));
if((~isempty(sctemp))&(~isnan(sctemp)))
    if(length(sctemp)>=2)
        score=sum(sctemp(length(sctemp)-1:length(sctemp))); % BLPOC socre equals to sum of the two highest scores.
        score=max(max(ff));
    else
        score=sctemp;
    end
else
     score=0;
end


%figure(11);
%mesh(ff);                 %%显示最大相关位置
end
    

