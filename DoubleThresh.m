function [ mask ] = DoubleThresh( deltaE, down, up )
%DOUBLETRESH �˴���ʾ�йش˺�����ժҪ
%  input��
%    deltaE���Ҷ�ͼ
%    down������ֵ
%    up������ֵ
%  output��mask����ֵ�����ͼƬ��

%�������ݹ����
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

