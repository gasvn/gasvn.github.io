---
title: Tips of  OpenCV
date: 2017-10-13 13:14:01
tags:
---
# OpenCV的使用方法积累
<!-- more -->
- 限制数字的范围到256以内

        saturate_cast<uchar>(a);
- 缩放图片 resize
```
resize(in,out,Size(in.cols/2,in.rows/2,));
第三个参数调整图片大小
```
- 向上取样 pyrUp 向上取样并模糊图像（其实就是放大） 
```
pyrUp(image, out, Size(image.cols * 2, image.rows * 2));
Size 要比以前大

```
- 向下取样 pyrDown 向下采样并模糊图像（缩小）
```
pyrDown(image, out, Size(image.cols /2, image.rows /2));
Size 要比以前小
```
- 原图转换成灰度图
```
cvtColor(image, gray, COLOR_BGR2GRAY);//变成灰度图
第三个参数可以改变，实现不同的转换
```
- Canay边缘检测
```C
Mat image = imread("C:\\WorkSpace\\CppProject\\LearnOpenCV\\LearnOpenCV\\resources\\1.jpg");
	Mat out;
	namedWindow("origin");
	imshow("origin", image);
	Canny(image, out, 3, 9, 3);//直接输出边缘检测 参数3：低阀值；参数4：高阀值；参数5：Sobel滤波器的孔径大小
	namedWindow("out");
	imshow("out", out);
	/*高阶Canny边缘检测方法：转成灰度图，降噪，用canny算法，得到的边缘作为掩码，拷贝原图到效果图上，得到彩色边缘图。*/
	Mat dst, edge, gray;
	dst.create(image.size(),image.type()); 
	cvtColor(image, gray, COLOR_BGR2GRAY);//变成灰度图
	blur(gray, edge, Size(3, 3));//对灰度图作降噪处理
	Canny(edge, edge, 3, 19, 3);
	dst = Scalar::all(0);//把dst内所有的元素设置成0
	image.copyTo(dst,edge);
	imshow("After Canny",dst);
	waitKey(0);
```
- 两张图片叠加
```
addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5,0, dst);
/*参数:输入图片1;参数2:图片1的融合比例;参数3:输入图片2;参数4:图片2的融合比例;参数5:偏差;参数6:输出图片*/
```