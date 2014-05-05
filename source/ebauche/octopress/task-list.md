---
layout: page
title: "Octopress 任务列表"
author: 郝海龙
date: 2014-05-05
comments: true
sharing: true
footer: true
---

- list element with functor item
{:toc}

## 已写入教程

**Octopress 搭建流程 – Github Pages：**

- 准备工作  
	- 安装 git   
	- 安装 Ruby   
	- 注册 Github 账号   
	- 域名指向  

- 本地安装 Octopress
- 将 Octopress 部署到 Github Pages  
	- 新建库 (Repository)  
	- 将本地部署的 Octopress 发布到 Github Pages  
	- 使用自己的域名（可选）

**Octopress 精益修改 (1)：**

- 新主题安装
- 基本配置
	- 域名，网站标题，作者
	- 日期格式
	- 文章链接形式
	- 分类目录前缀
	- 「继续阅读」按钮
	- 修改 Markdown 文件后缀  
	- 修改默认 Markdown 解释器 (Rdiscount to kramdown)
		- 添加数学公式

**Octopress 精益修改 (2)：**

- 主题修改
	- 页面相关设置
		- 新建页面
		- 添加404 公益页面
		- 添加页面和其他链接至导航栏
	- 主题汉化
		- 汉化导航栏
		- 汉化移动设备导航栏
		- 汉化归档页面
		- 汉化侧边栏
		- 汉化其他部分
	- 网站底部
	- 添加侧边栏
	- 添加评论系统

**Octopress 精益修改 (3)：**

- 样式修改
	- 网站布局
		- 修改框架宽度
		- 修改内容宽度
	- 页面字体
	- 修改连接样式
	- 给中英文间添加空格

**Octopress 精益修改 (4)：**

- 元素美化
	- Coderay 实现更美观的代码显示。 
		自己做了个插件修改版……
	- 给图片添加 Caption 
	- 使用 FontAwesome 

## 待写入教程

- 必备功能
	- 侧边栏分类目录
	- 长文档自动生成目录
	- 文章尾部添加版本修订信息

## 暂不计划写入教程的功能及原因

- 添加 ADN 页面
	
	我使用了[ADN侧边栏插件](https://github.com/octopress/adn)，但用它生成了一个页面，解决得并不完美，想来大部分人也用不着这个功能，就不专门写了。

- 图床问题
	
	可以直接使用 Github 在[精益修改 (4)](http://s.olo.la/eay3) 中有介绍，我用的是 [Droplr](https://droplr.com/join/d/kJSa8cTQ).

- 搜索引擎优化
	
	本博客作为个人学习使用的博客，并没有做 SEO（或许哪天学习 SEO 时会做一下），有需要的朋友请参考丁培轩翻译的这篇文章：<http://s.olo.la/s5Ue>

- 脚注：Bigfoot
	
	请参考 Bigfoot 官网：<http://www.bigfootjs.com>

- 添加提示框
	
	本文文章前面的 info 信息框以及文章中的 warning 警告框，其实都是用样式表制作出来的，使用了两幅简易的背景图片，具体请参考雁起平沙的 Octopress 样式表：<http://s.olo.la/xFy5>