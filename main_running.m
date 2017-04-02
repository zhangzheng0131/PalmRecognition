close all;
clear;
clc;
azz=1;
   
for izz=51:51
    filename=['.\..\IITDR\' num2str(izz,'%03d')];
    for zzz=1:1
        if(zzz~=izz)
            filenamej=['.\..\IITDR\' num2str(zzz,'%03d')];
            for jzz=1:5
                for bzz=1:5
                filename1=[filename '/' num2str(izz,'%03d') '_' num2str(bzz) '.bmp'];
                I0t=imread(filename1);
                filename2=[filenamej '/' num2str(zzz,'%03d') '_' num2str(jzz) '.bmp'];
                J0t=imread(filename2);
                end
                imposterMScore(azz)=PDPOC(I0t,J0t);
                azz=azz+1;
            end
        end
    end
end
save imposterMScore imposterMScore;