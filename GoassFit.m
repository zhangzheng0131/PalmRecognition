function [ LocalScore ] = GoassFit(x,y)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明


y1=fliplr(y)/fliplr(max(y));
x1=fliplr(x)/fliplr(max(x));


ymax=max(y); %确定y 纵轴的最大值，将来复原使用。

%上面是将数据从小到大排列，并且归一化。

%% Calculate coefficient  定义拟合的函数，这个函数工作在[01] 区间，参看fittype的帮助文件。
fun=fittype('A*exp(-(x-mu)^2/(2*sigma^2))');

[cf,gof]=fit(x1(:),y1(:),fun,'Start',[1,0.5,0.1]);
%求出拟合系数的结构体cf 。
%% Interpolate the data
%对你的数据进行插值，这样画图会比较好看。
k=1:length(x1);
ki=linspace(1,length(x1),2000);
xi=interp1(k,x1,ki,'linear');
yi=interp1(k,y1,ki,'linear');
%计算拟合后的数据（Y）同时将y的数值还原。
Yi=cf.A*exp(-(xi-cf.mu).^2/(2*cf.sigma^2))*ymax;


LocalScore=cf.A*1*ymax;
if(LocalScore>=1)
    LocalScore=1;
end
%% plot data
%figure(10);
%hold on
%plot(x,y,'ro');   %原始数据

%plot(xi*max(x),Yi,'b'); % 拟合曲线

end

