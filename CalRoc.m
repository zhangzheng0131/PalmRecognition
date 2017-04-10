function []=CalRoc()
load('imposterMScore.mat');
load('MScore.mat');
MScore=MScore;
%negsample=zeros(length(imposterMScore),1);
negsample=(-1)*ones(length(imposterMScore),1);
%possample=ones(length(MScore),1);
possample=ones(length(MScore),1);
data=[MScore imposterMScore];
label=[possample' negsample'];
%plotroc(label,data);
%[tpr,fpr,thresholds] = roc(label,data);
[tpr,fpr] = roczz(label',data');
h=figure(100);
semilogx(fpr,tpr);
f=['v1_' num2str(i) '.png'];
saveas(h,f);
grid on;
figure(101);
plot(fpr,tpr);
grid on;
end
