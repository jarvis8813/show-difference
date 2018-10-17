function [ mask ] = DoubleThresh( deltaE, down, up )
%DOUBLETRESH 此处显示有关此函数的摘要
%  input：
%    deltaE：灰度图
%    down：下阈值
%    up：上阈值
%  output：mask（二值化后的图片）

%设置最大递归深度
set(0,'RecursionLimit',10000);
[H,W] = size(deltaE);
mask = im2bw(deltaE,up);
 
for i=1:H
    for j=1:W  
      if mask(i,j)==1
          mask=connect(deltaE,mask,i,j,down);     
      end
    end
end

end

