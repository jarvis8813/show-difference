# show-difference
compare two images and show the difference in a fixed fisheye camera

## 使用环境：<br>
MATLAB win10<br>

## 使用方法：<br>
1.将code和'./diff''./same'等需测试的文件夹放在同一个目录下<br>
2.打开MATLAB，run ShowDiff.m即可<br>
3.结果将以二值化图片形式存于'./result'文件夹内<br>

## 原理步骤：<br>
1.计算两图像Lab色彩空间下的deltaE距离；<br>
2.使用双阈值法将deltaE较大的连通图画出来；<br>
3.使用形态学操作进行后处理。<br>
