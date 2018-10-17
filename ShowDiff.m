clc,clear,close all;
% 修改root来确定你想测试的文件夹('diff'or'same')
root = 'diff';
for pair = 1:20
    im1 = imread(sprintf('./%s/%d-1.jpg',root,pair));
    im2 = imread(sprintf('./%s/%d-2.jpg',root,pair));
%   去燥处理
    gaussian_f =fspecial('gaussian',[7,7],1.414);
    im1_blur=imfilter(im1,gaussian_f,'replicate');
    im2_blur=imfilter(im2,gaussian_f,'replicate');
%   将RGB图片转换为Lab格式
    [im1_L, im1_a,im1_b] = rgb2lab(im1_blur);
    [im2_L, im2_a,im2_b] = rgb2lab(im2_blur);
    
%   核心公式，求两张图Lab值的deltaE距离
    deltaE = sqrt((im2_L - im1_L).^2+(im2_a-im1_a).^2+(im2_b-im1_b).^2);
    
    eps = 60;  %超参数eps，用来防止两张相同图片的deltaE最大值太小
    deltaE = deltaE./max(max(max(deltaE)),eps); %归一化
    
%   由于后面双阈值法使用了递归，而原图分辨率太高像素过多
%   会超出递归深度。因此为了简化计算，resize deltaE灰度图
    deltaE = imresize(deltaE,0.5);
%   设定双阈值的上下限
    down = 0.3;
    up = 0.6;
%   双阈值法
    result = DoubleThresh(deltaE,down,up);
    
%   一些后处理，形态学操作除去没意义的白点;
%   由于空洞内大概率为移动物体，用imfill函数将图像空洞填充
    se1=strel('disk',7');
    result = imresize(result,2);
    result = imopen(result,se1);
    result = imdilate(result,se1);
    result = imfill(result,'hole');
    
%   输出图片
    if ~exist('./result','dir')==1
        mkdir('./result');
    end
    mask = 1-result;
    imwrite(double(result),sprintf('./result/%s-%d.png',root,pair),'Alpha',mask)
    fprintf('finish processing image pair %d\n',pair);
end