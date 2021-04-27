# CT  系统矩阵仿真程序

## 内容列表

 [背景](#背景)
* [安装](#安装)
* [示例](#示例)
  * [如何使用](#如何使用)
* [参考文献](#参考文献)
* [使用许可](#使用许可)



## 背景

对于大多数CT(计算机断层扫描)初学者来说，有时很难理解系统矩阵的物理意义以及它是如何生成或计算的。这个小应用程序可以帮助你直观地理解系统矩阵是如何工作的及其物理意义。

系统矩阵的构造受扫描几何、检测器结构、目标密度函数估计等因素的影响。我们可以根据光束与物体的像素(体素)相互作用的强度来定义相应像素对线积分的贡献的权重。常用的系统矩阵(或投影矩阵)建模方法有三种:

1. 点模型
2. 线模型;
3. 面积模型.

在这个示例中，我使用线模型，具体来说，我使用siddon算法来计算系统矩阵(8X8)。

## 安装

打开"CTProjVisible.m", 点击 “Run” 运行.

## 示例

![](./images/GUI.png)

有三个面板:

1. 第一个是坐标轴，它有一个代表8个像素的8X8网格;;
2. 量化彩色图像面板，它使用不同的颜色来区分给定的射线是否通过特定的像素;
3. 长度数据表格，此表列出了给定的射线与特定像素方格的相交长度;

### 如何使用

* 你可以设置投影角度和探测器索引，然后按“Draw the Proj Line”按钮，显示该射线与像素的交点。.
* 你也可以按下“开始”按钮，遍历所有角度。

## 参考文献

* [Siddon R L. Fast calculation of the exact radiological path for a three-dimensional CT array[J]. Medical physics, 1985, 12(2):252–255.](https://sci-hub.se/10.1118/1.595715)

## 使用许可

[GPL](LICENSE) © Ridge Wong




