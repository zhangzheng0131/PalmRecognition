%˵��
%��λ��ط��ǻ��ڸ��Ϲ����׵���ؼ������÷�������
%���������е���λ��Ϣ����ͼ����׼����ͼ������ȱ任�����У�����
%���׻��������ϵ��


function [ff1,score,rawdis,coldis] = phasecorrelation(IS,IF)
%IS=imread('view1.bmp');      %Դͼ��
if(size(IF)~=size(IS))
        
end
fftIS=fft2(im2double(IS));   
%IF=imread('view2.bmp');      %ƥ��ͼ��
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
%mesh(ff);                 %%��ʾ������λ��
    end
    

