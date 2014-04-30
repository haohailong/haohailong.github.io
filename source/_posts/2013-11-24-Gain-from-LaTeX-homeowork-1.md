---
layout: post
title: "第一份 LaTeX 作业心得"
date: 2013-11-24 03:03
comments: true
categories: "LaTeX"
---

由于工作原因，很多文档需要用 LaTeX 写作。去年曾经花三天时间阅读了 LaTeX 经典文档 <a href="http://mirror.ox.ac.uk/sites/ctan.org/info/lshort/english/lshort.pdf" target="_blank"  title="The (Not So) Short Introduction to LaTeX2e">*The (Not So) Short Introduction to LaTeX2e*</a>，但毕竟不是天天用它写文章，一些功能特性很快就忘了。

到了真正写论文的时候，我的同事 Alina 和导师 Cristina 都推荐我用 <a href="http://www.lyx.org" target="_blank" title="Lyx">Lyx</a>。我必须承认这个「所见即所得」的 LaTeX 编辑器功能很强大，可以满足你学术写作的大部分需求——如果不是全部的话。但是，不得不说 Lyx 有些功能的实现需要在版面美观方面做出一定让步。这让我这个细节强迫症痛苦不已。
<!--more-->

于是，我决定转回 WYSIWYM [^1]模式的 LaTeX，重新学习 LaTeX 也就成了必然，这一次我用的教材是 <a href="http://www.amazon.com/Guide-LaTeX-Edition-Helmut-Kopka-ebook/dp/B00256Z3G8/ref=tmm_kin_title_0?ie=UTF8&qid=1385070416&sr=8-1" target="_blank">*Guide to LaTeX*</a>。为了避免再次忘掉，除了完成书上的练习之外，我决定给自己布置作业，以便可以应对真实的排版情况。

今天（其实已经是昨天了）我刚刚完成第一份作业——<a href="http://haohailong.net/archives/gre-sentence-completion-tutorial-8-1.vie" target="_blank">重排「《GRE填空教程》英汉对照8.1版」</a>（感兴趣的朋友可以点击链接看一下我的作业做得怎么样）。完成这份作业总共花了我整整两天时间，每天几乎都是从早做到晚。一般而言，精疲力竭之后总会有不少收获，这次也不例外。一些心得摘录在此：

1. 再次明白了作业的重要性。很多事情不做，永远不可能知道是怎么回事：做这份作业之前，我以为我可以花半天时间搞定所有的事情，可是真正做的时候意外却接二连三的发生。
2. 遇到问题不要轻易放弃，即使解决不了，解决问题的过程也可能带来意外收获。这次为了解决一个批处理的问题，写了两个 AppleScript 脚本程序，最终问题靠别的方法解决的，但因此看了两本 AppleScript 教程，对 AppleScript 有了更深的了解。
3. 就 LaTeX 排版而言，如果一直正常的文档突然出现排版 (Typeset) 错误，而且在你撤销上一步的情况下无法恢复，很有可能是你上一步操作修改了其他相关文件所致，可以尝试删掉除去 TeX 文件之外的所有文件重试，必要时可以用源代码新建文档重试。
4. 用其他文字处理软件排版的中文文档，如果你想用 LaTeX 重新排版需要注意（可以当做检查列表）：

	> 1. 之前指定的文字样式全部消失（加粗、斜体、下划线），需要用 LaTeX 命令重写。重点要注意一些图书或者文章的名称，英文中没有书名号，需要用斜体来标出图书或文章的名称。
	> 2. 英文的引号需要重新检查。在 LaTeX 中，用两个`（重音符号）产生左侧双引号，用两个'（直立引 号）产生右侧双引号，不能直接用键盘上的双引号代替，否则前后都会变成难看的直立引号。
	> 3. 特殊字符，比如法语中的 é，LaTeX 有专门的输入方法。不过在 XeLaTeX 排版系统中，似乎直接输入 é 有时也可以正常显示，但为了保险起见还是老老实实输入 LaTeX 代码吧，事实上我就碰到过直接输入报错的情况。不过可以考虑安装相应的宏包，比如 **Package:** inputenc。
	> 4. 撇号。无论是英文中表示缩写和所有格的 apostrophe 还是数学中的 prime 都有可能产生风格不统一的情况，需要仔细检查。

5. 如果出现宏包冲突的情况，可以尝试其他类似功能的宏包。毕竟 LaTeX 算是个开源项目，贡献的人不少，很多宏包都能提供相同或类似的功能。比如，我在使用 **Package:** titletoc 的时候与 **Package:** hyperref 冲突了，后来我改用 **Package:** tocloft 解决了问题。
6. 用 LaTeX 排版中文文档比英文文档痛苦多了。如果你在国内读大学，学术论文主要用中文来写作，还是用 Word 或者 Pages 去排版好了。[^2]
7. 在排版过程中犯了个错误。我把 chapter 命令的 name 改成了 Exercise，因为我排的文档由76个练习组成；然后我让目录显示 chapter 的 caption，这样在目录中就可以看到 Exercise 1 一直到 Exercise 76。但由于没有给章节录入标题，导致在文档结构图上，练习1到练习76都是一片空白。事实上，点击空白处也可以跳到相关章节，但用着很不爽。针对这个问题，不知道各位读者有没有比较简便的解决办法。
8. Nespresso 胶囊还是原厂出的最好喝。其中个人最喜欢（排名不分先后，我没有收雀巢赞助费）：Dharkan, Roma, Fortissio Lungo, Ristretto, Decaffeinato Intenso.

[^1]: WYSIWYM: What you see is what you mean.
[^2]: 毕竟国内经常让提交 Word 版。我碰到过某些老师电脑里甚至没有PDF阅读器。