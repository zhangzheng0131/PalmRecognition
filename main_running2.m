close all;
clear;
clc;
genuineC=[1 2;1 3;1 4; 1 5; 2 3; 2 4; 2 5;3 4 ; 3 5;4 5
    ];
wt=[12:2:32];
for i=1:length(wt)
    W=wt(i);
for izz=1:57% 23%0
    filename=['.\..\..\IITDR\' num2str(izz,'%03d')];
    for jzz=1:10
        filename1=[filename '\' num2str(izz,'%03d') '_' num2str(genuineC(jzz,1)) '.bmp'];
        I0t=imread(filename1);
        filename2=[filename '\' num2str(izz,'%03d') '_' num2str(genuineC(jzz,2)) '.bmp'];
        J0t=imread(filename2);
        jzz
        izz
        MScore((izz-1)*10+jzz)=PDPOC(I0t,J0t,W);
    end
end                                                                                                                                                                                                                              
save MScore MScore;
azz=1;
for izz=224:224%30
    filename=['.\..\..\IITDR\' num2str(izz,'%03d')];
    for zzz=1:23%0
        if(zzz~=izz)
            filenamej=['.\..\..\IITDR\' num2str(zzz,'%03d')];
            for jzz=1:5
                for bzz=1:5
                filename1=[filename '\' num2str(izz,'%03d') '_' num2str(bzz) '.bmp'];
                I0t=imread(filename1);
                filename2=[filenamej '\' num2str(zzz,'%03d') '_' num2str(jzz) '.bmp'];
                J0t=imread(filename2);
                imposterMScore(azz)=PDPOC(I0t,J0t,W);
                azz=azz+1
                end
                
            end
        end
    end
end
save imposterMScore imposterMScore
CalRoc;

end

