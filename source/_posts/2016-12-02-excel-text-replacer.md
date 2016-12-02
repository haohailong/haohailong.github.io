---
layout: post
title: "Excel 文本批量替换器"
date: 2016-12-02 15:42:30 +0800
comments: true
categories: "App"
---
![Excel 文本批量替换器 头图](https://raw.githubusercontent.com/haohailong/imagebed/master/Excel-text-replacer-bg-design-sketch.jpeg "Excel 文本批量替换器 头图")

是的，在我司产品经理的逼迫下我用 AppleScript 写了个批量处理 Excel 的 App。主要功能是针对某一文件夹下所有的 Excel 文件，批量「查找和替换」文本，严格对应区分大小写。可能各位在平时处理 Excel 文件也会有用，分享给大家。

（下载地址在文末）

### 我想说的一些话

这个应用虽然简单，但对我来说很重要，因为这不仅仅是我写的第一个应用，也印证着我一直以来对于编程的态度：我们每个人都应该学一点编程，并不是为了写出多么高大上的应用，而是为了实实在在解决一些个人遇到的非普遍性的小问题。

事实上，我原本也没有想过要把它打包成一个 App，但想到既然我有这样的需求，那么也会有其他人有同样的需求。于是，这就变成了我的第一个完整打包的 Mac 应用。

而能打包成 App 也要得益于一直以来 [@ibuick](http://weibo.com/ibuick "ibuick 的微博") [@tinyfool](http://weibo.com/tinyfool "tinyfool 的微博") [@人字拖2号](http://weibo.com/leeyoung7 "有才的微博") 的耳濡目染——主要是耳濡，让我了解到哪怕是 AppleScript 这样的傻瓜式脚本程序也可以打包成完整的应用，在此对他们表示感谢。

### 关于图标

![Excel 文本批量替换器 Icon](https://raw.githubusercontent.com/haohailong/imagebed/master/Excel-text-replacer.png "Excel 文本批量替换器 Icon")

也许有人看过昨天 @人字拖2号 的「爆料」，上面这款应用的图标是一根用 Sketch 制作的冰棍，这根冰棍其实是我模仿 dribbble 上 [Oliver Ker 先生](https://dribbble.com/oliverker "Oliver Ker 的 dribbble 主页")的作品，当时是作为设计练习作业做的，因为版权问题，我正式发出来的版本并没有使用这个图标。而是重新绘制了一个图标。

新图标的形状是一个修正液的瓶子，暗示了软件「用新的替换旧的」的意思，X 的图标表示 Excel 文件，而 Correction Script 的标签来自英文表示修正液的词 Correction Fluid。

坦白讲，绘制这个图标并没有花多长时间，但让我有信心能够绘制出这样一个图标，我想感谢 [@周楷雯Kevin](http://weibo.com/kevinzhow "周楷雯 的微博")，是他的 Producter 这本书让我觉得其实绘制这些 Logo 没有我想象的那么难。

## 注意事项

程序使用 AppleScript 编写，主要思路是让系统自动依次打开一个文件夹下所有 Excel，并按规则替换。由于没有用到直接读写 Excel 的包，为避免出错，运行过程中最好不要做其他事情。尽管如此，已经可以节约我很长时间了，昨天我处理 90 个文件，大约用了 6 分钟（比上不足，比下有余）。

下载地址：[Excel 文本批量替换器](https://raw.githubusercontent.com/haohailong/imagebed/master/Excel-text-replacer.dmg "Excel 文本批量替换器")