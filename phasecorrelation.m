%说明
%相位相关法是基于傅氏功率谱的相关技术。该方法利用
%互功率谱中的相位信息进行图像配准，对图像的亮度变换不敏感，而且
%容易获得最大相关系数


function [ff1,score,rawdis,coldis] = phasecorrelation(IS,IF)
%IS=imread('view1.bmp');      %源图像
if(size(IF)~=size(IS))
        
end
fftIS=fft2(im2double(IS));   
%IF=imread('view2.bmp');      %匹配图像
fftIF=fft2(im2double(IF));
fftISG=conj(fftIS);

%A=fftISG.*fftIF;
A=fftIF.*fftISG;
AA=abs(A);
PS=A./AA;
[c,i]=max(ifft2(PS),[],1);
ff=ifft2(PS);
ff1=ff;
if(max(max(ff))<abs(min(min(ff))))
    %[coldist,rawdist]= find(ff==min(min(ff))); 
    coldis=0;
    rawdis=0;
else
    ff=abs(ifft2(PS));
    [coldist,rawdist]= find(ff==max(max(ff)));        % calculate the displacement
    coldis=coldist;
    rawdis=rawdist;
end
if isempty(coldis)||isempty(rawdis)
    coldis=0;
    rawdis=0;
end
if((coldis<=0.5*size(ff,2))&&(rawdis<=0.5*size(ff,1)))
    coldis=coldis-1;
    rawdis=rawdis-1;
end
if((coldis>0.5*size(ff,2))&&(rawdis<=0.5*size(ff,1))) %4 kinds of conditions 
        coldis=coldis-1-size(ff,2);
        rawdis=rawdis-1;
end
 if((coldis<=0.5*size(ff,2))&&(rawdis>0.5*size(ff,1)))
        coldis=coldis-1;
        rawdis=rawdis-1-size(ff,1);
end
if((coldis>0.5*size(ff,2))&&(rawdis>0.5*size(ff,1)))
        coldis=coldis-1-size(ff,2);
        rawdis=rawdis-1-size(ff,1);
end


%if(mod(coldis+))
score=max(max(ff));
%figure(11);
%mesh(ff);                 %%显示最大相关位置
    end
    

