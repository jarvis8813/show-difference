clc,clear,close all;
% �޸�root��ȷ��������Ե��ļ���('diff'or'same')
root = 'diff';
for pair = 1:20
    im1 = imread(sprintf('./%s/%d-1.jpg',root,pair));
    im2 = imread(sprintf('./%s/%d-2.jpg',root,pair));
%   ȥ�ﴦ��
    gaussian_f =fspecial('gaussian',[7,7],1.414);
    im1_blur=imfilter(im1,gaussian_f,'replicate');
    im2_blur=imfilter(im2,gaussian_f,'replicate');
%   ��RGBͼƬת��ΪLab��ʽ
    [im1_L, im1_a,im1_b] = rgb2lab(im1_blur);
    [im2_L, im2_a,im2_b] = rgb2lab(im2_blur);
    
%   ���Ĺ�ʽ��������ͼLabֵ��deltaE����
    deltaE = sqrt((im2_L - im1_L).^2+(im2_a-im1_a).^2+(im2_b-im1_b).^2);
    
    eps = 60;  %������eps��������ֹ������ͬͼƬ��deltaE���ֵ̫С
    deltaE = deltaE./max(max(max(deltaE)),eps); %��һ��
    
%   ���ں���˫��ֵ��ʹ���˵ݹ飬��ԭͼ�ֱ���̫�����ع���
%   �ᳬ���ݹ���ȡ����Ϊ�˼򻯼��㣬resize deltaE�Ҷ�ͼ
    deltaE = imresize(deltaE,0.5);
%   �趨˫��ֵ��������
    down = 0.3;
    up = 0.6;
%   ˫��ֵ��
    result = DoubleThresh(deltaE,down,up);
    
%   һЩ������̬ѧ������ȥû����İ׵�;
%   ���ڿն��ڴ����Ϊ�ƶ����壬��imfill������ͼ��ն����
    se1=strel('disk',7');
    result = imresize(result,2);
    result = imopen(result,se1);
    result = imdilate(result,se1);
    result = imfill(result,'hole');
    
%   ���ͼƬ
    if ~exist('./result','dir')==1
        mkdir('./result');
    end
    mask = 1-result;
    imwrite(double(result),sprintf('./result/%s-%d.png',root,pair),'Alpha',mask)
    fprintf('finish processing image pair %d\n',pair);
end