function [ LocalScore ] = GoassFit(x,y)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


y1=fliplr(y)/fliplr(max(y));
x1=fliplr(x)/fliplr(max(x));


ymax=max(y); %ȷ��y ��������ֵ��������ԭʹ�á�

%�����ǽ����ݴ�С�������У����ҹ�һ����

%% Calculate coefficient  ������ϵĺ������������������[01] ���䣬�ο�fittype�İ����ļ���
fun=fittype('A*exp(-(x-mu)^2/(2*sigma^2))');

[cf,gof]=fit(x1(:),y1(:),fun,'Start',[1,0.5,0.1]);
%������ϵ���Ľṹ��cf ��
%% Interpolate the data
%��������ݽ��в�ֵ��������ͼ��ȽϺÿ���
k=1:length(x1);
ki=linspace(1,length(x1),2000);
xi=interp1(k,x1,ki,'linear');
yi=interp1(k,y1,ki,'linear');
%������Ϻ�����ݣ�Y��ͬʱ��y����ֵ��ԭ��
Yi=cf.A*exp(-(xi-cf.mu).^2/(2*cf.sigma^2))*ymax;


LocalScore=cf.A*1*ymax;
if(LocalScore>=1)
    LocalScore=1;
end
%% plot data
%figure(10);
%hold on
%plot(x,y,'ro');   %ԭʼ����

%plot(xi*max(x),Yi,'b'); % �������

end

