function [im]=pool(image)
izz=1;
for i=1:2:size(image,1)
    jzz=1;
    for j=1:2:size(image,2)  
        im(izz,jzz)=mean(mean(double(image(i:i+1,j:j+1))));
        jzz=jzz+1;
    end
    izz=izz+1;
end
end