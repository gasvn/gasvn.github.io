---
title: Ubuntu安装NVIDIA显卡驱动循环登录解决方法
date: 2017-10-11 12:08:06
tags:
---
# 前言

实验室电脑配置环境Ubuntu16.04+cuda8.0+cudnn5.0，

# 环境


系统：Ubuntu16.04 64bit 
显卡：Nvidia GFoce GTX TITAN X 
驱动：nvidia 375.20 
软件版本：cuda8.0 + cudnn5.0

# 问题声明

在ubutnu上配置cuda时需要安装nvidia的驱动，所以在安装了驱动后出现了进入Ubuntu循环登录的问题。为了使用intel核显和NVIDIA独显。
<!-- more -->
# 问题解释（大概）

以下属于我的猜测

一般而言我们安装的ubuntu 的显示器并没有接到nvidia的显卡上，而是使用了intel的集显。我们安装驱动其实只是想将我们运算的显卡的驱动更新，结果都给搞了，所以产生了冲突。当然，也可能时opengl产生的冲突（就是opengl的锅）。

# Nvidia驱动正确安装过程

- 找到适合的正确的驱动

    去nvidia驱动官网下载

- 卸载掉原有驱动
```

sudo apt-get remove –purge nvidia*
```
或者
```
如果安装的是官网下载的驱动
则重新运行run文件来卸载
sh ./nvidia.run --uninstall
```
# 安装驱动

- 进入命令行界面

        Ctrl-Alt+F1
- 给驱动run文件赋予执行权限

        sudo chmod a+x NVIDIA-Linux-x86_64-375.20.run
- 安装(注意 参数 **一个不能少**)

```
sudo ./NVIDIA-Linux-x86_64-375.20.run –no-x-check –no-nouveau-check –no-opengl-files
```
–no-x-check 安装驱动时关闭X服务
–no-nouveau-check 安装驱动时禁用nouveau
–no-opengl-files 只安装驱动文件，不安装OpenGL文件
重启，并不会出现循环登录的问题  
**其他安装全部默认选项**

# 禁忌

安装CUDA时一定使用runfile文件，这样可以进行选择。不再选择安装驱动，以及在弹出xorg.conf时选择NO
不要使用ubuntu设置中附加驱动中驱动
提醒

cuda安装时会将源文件装在/usr/local/cuda-8.0下，然后会创建一个/usr/local/cuda的链接，所以在安装tensorflow设置cuda和cudnn路径以及拷贝cudnn文件到cuda文件夹下时，注意使用真实的路径
在安装了cuda之后再安装nvidia驱动,可能这和网上“流传”的教程有些出入，但是长得帅的人都这样做了，换句话说，这样做的话会避免出现一些奇怪的问题。比如：tf安装好了出现的缺少libcuda.so.1
再结合各个框架官网的安装教程。

主要参考[链接](http://blog.csdn.net/u010159842/article/details/54344683)