
function [MScore]=PDPOC(I0t,J0t)

%I0t=imread('001_1.bmp');               % Source Image I
I0=imresize(I0t,[160,160],'bicubic');
%I1=averagePooling2dLayer(2,'Stride',2)
%J0t=imread('001_2.bmp');               % Source Image J
J0=imresize(J0t,[160,160],'bicubic');
%I1=IS(1:2:size(IS,1),1:2:size(IS,2));  % Down Sampling
I1=pool(I0);
I2=pool(I1);
J1=pool(J0);
J2=pool(J1);
p01=[32:8:128];
p02=[32:8:128];
p11=round(p01/2);
p12=round(p02/2);
p21=round(p11/2);
p22=round(p12/2);
%Q=[25:6:97];
%figure(1);
%imshow(I0);
%hold on;
for izz=1:size(p01,2)
   for jzz=1:size(p02,2)  
    %plot(p01(1,izz),p02(1,jzz),'o');
   end
end

[ff2,Score,col2dis,raw2dis]=phasecorrelation(I2,J2);      % estimate displacement between
%q11=sqrt(power(p1,2)+rawdis^2);
q21=p21+raw2dis;                                %step 3  
q22=p22+col2dis;
q11t=2*q21;                                      %step4
q12t=2*q22;
W=28;

for izz=1:size(p11,2)
   for jzz=1:size(p12,2)  
    f1=I1(max(p11(1,izz)-W/2,1):min(p11(1,izz)+W/2-1,size(I1,1)),max(p12(1,jzz)-W/2,1):min(p12(1,jzz)+W/2-1,size(I1,2)));
    g1=J1(round(max(q11t(1,izz)-W/2,1)):round(min(q11t(1,izz)+W/2-1,size(J1,2))),round(max(q12t(1,jzz)-W/2,1)):round(min(q12t(1,jzz)+W/2-1,size(J1,2))));
    for temp=1:1
    if((size(f1,1)<W)&&(size(f1,2)==W))
        %for tzz=1:size(p01,2)
            f1(size(f1,1)+1:size(I1,1),:)=0;
        %end
    end
       if((size(f1,2)<W)&&(size(f1,1)==W))
        %for tzz=1:size(p01,2)
            f1(:,size(f1,2)+1:size(I1,2))=0;
        %end
       end
    if((size(f1,1)<W)&&(size(f1,2)<W))
        %for tzz=1:size(p01,2)
            f1(size(f1,1)+1:W,:)=0;
            f1(:,size(f1,2)+1:W)=0;
            f1(size(f1,1)+1:W,size(f1,2)+1:W)=0;
        %end
    end
      if((size(g1,1)<W)&&(size(g1,2)==W))
        %for tzz=1:size(p01,2)
            g1(size(g1,1)+1:W,:)=0;
        %end
    end
       if((size(g1,2)<W)&&(size(g1,1)==W))
        %for tzz=1:size(p01,2)
            g1(:,size(g1,2)+1:W)=0;
        %end
       end
    if((size(g1,1)<W)&&(size(g1,2)<W))
        %for tzz=1:size(p01,2)
            g1(size(g1,1)+1:W,:)=0;
            g1(:,size(g1,2)+1:W)=0;
            g1(size(g1,1)+1:W,size(g1,2)+1:W)=0;
        %end
    end
    end 
    [ff1,POCsco1,col1dis(izz,jzz),raw1dis(izz,jzz)]=phasecorrelation(f1,g1);      %setp 5
    izz;
    jzz;
    q11(izz,jzz)=2*q21(1,izz)+raw1dis(izz,jzz);
    q12(izz,jzz)=2*q22(1,jzz)+col1dis(izz,jzz);
   end
end
%step 6
q01t=2*q11;
q02t=2*q12;
W=28;
%figure(2);
%imshow(J0);
%hold on
for izz=1:size(p01,2)
   for jzz=1:size(p02,2)  
    f1=I0(max(p01(1,izz)-W/2,1):min(p01(1,izz)+W/2-1,size(I0,1)),max(1,p02(1,jzz)-W/2):min(p02(1,jzz)+W/2-1,size(I0,2)));
    g1=J0(round(max(q01t(izz,jzz)-W/2,1)):round(min(q01t(izz,jzz)+W/2-1,size(J0,1))),round(max(1,q02t(izz,jzz)-W/2)):round(min(q02t(izz,jzz)+W/2-1,size(J0,2))));
    for temp=1:1
    if((size(f1,1)<W)&&(size(f1,2)==W))
        %for tzz=1:size(p01,2)
            f1(size(f1,1)+1:W,:)=0;
        %end
    end
       if((size(f1,2)<W)&&(size(f1,1)==W))
        %for tzz=1:size(p01,2)
            f1(:,size(f1,2)+1:W)=0;
        %end
       end
    if((size(f1,1)<W)&&(size(f1,2)<W))
        %for tzz=1:size(p01,2)
            f1(size(f1,1)+1:W,:)=0;
            f1(:,size(f1,2)+1:W)=0;
            f1(size(f1,1)+1:W,size(f1,2)+1:W)=0;
        %end
    end
      if((size(g1,1)<W)&&(size(g1,2)==W))
        %for tzz=1:size(p01,2)
            g1(size(g1,1)+1:W,:)=0;
        %end
    end
       if((size(g1,2)<W)&&(size(g1,1)==W))
        %for tzz=1:size(p01,2)
            g1(:,size(g1,2)+1:W)=0;
        %end
       end
    if((size(g1,1)<W)&&(size(g1,2)<W))
        %for tzz=1:size(p01,2)
            g1(size(g1,1)+1:W,:)=0;
            g1(:,size(g1,2)+1:W)=0;
            g1(size(g1,1)+1:W,size(g1,2)+1:W)=0;
        %end
    end
    end   % boundary condition
    [ff1,BLPOCsco0(izz,jzz),col0dis(izz,jzz),raw0dis(izz,jzz)]=phasecorrelation(f1,g1);      %setp 5
    if(isnan(ff1))
        ff(:,:,(izz-1)*size(p01,2)+jzz)=0.01*eye(size(ff1,1));
    else
        ff(:,:,(izz-1)*size(p01,2)+jzz)=ff1;
    end
    izz;
    jzz;
    
    q01(izz,jzz)=2*q11(izz,jzz)+raw0dis(izz,jzz); %periodic extension
    q02(izz,jzz)=2*q12(izz,jzz)+col0dis(izz,jzz);
  %  plot(q01(izz,jzz),q02(izz,jzz),'*');
    
    %dis(izz,jzz)=sqrt(raw0dis(izz,jzz)^2+col0dis(izz,jzz)^2); % calculate distance of spliting for blocks
   end
end
%%%%% matching score calculate

%scoretemp=sort(BLPOCsco0(:,:));
%BLPOCscore=mean(scoretemp(1:7));  
%% average BLPOC function
fftemp=mean(ff,3);
BLPOCscore=max(max(fftemp));
%%%%% Location-based Score
for izz=1:size(q01,2)
    for jzz=1:size(q02,2)-1
        distenr((izz-1)*(size(q02,2)-1)+jzz)=sqrt((q01(izz,jzz)-q01(izz,jzz+1))^2+(q02(izz,jzz)-q02(izz,jzz+1))^2);     % calculate distance of spliting for blocks
    end
end 
for jzz=1:size(q02,2)
    for izz=1:size(q01,2)-1
        distenc((jzz-1)*(size(q02,2)-1)+izz)=sqrt((q01(izz,jzz)-q01(izz+1,jzz))^2+(q02(izz,jzz)-q02(izz+1,jzz))^2);     % calculate distance of spliting for blocks
    end
end 

disten=[distenr distenc];
azz=1;
for izz=1:length(disten)
    if (disten(izz)<=30)
        distenc(azz)=disten(izz);
        azz=azz+1;
    end
end
%figure(3);
[X,Y]=hist(distenc,30);
y=X/length(disten);
x=[1:1:30];
LocalScore=GoassFit(x,y);

MScore=0.5*(BLPOCscore+LocalScore);
    if((MScore>=1)||isnan(MScore))
        MScore=0.10;
    end
end
                                        
%J1=JS(1:2:size(JS,1),1:2:size(JS,2));  % Down Sampling