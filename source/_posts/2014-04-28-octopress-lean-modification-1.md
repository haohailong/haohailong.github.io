---
layout: post
title: "Octopress 精益修改 (1)"
date: 2014-04-28 23:31:59
comments: true
categories: "Octopress"
---

- list element with functor item
{:toc}

## 永远的第二步

通过「[Octopress 搭建流程 – Github Pages](http://shengmingzhiqing.com/blog/setup-octopress-with-github-pages.html/)」，我们搭建好了自己的 Octopress 博客并发布了第一篇文章。

但这只是我们 Octopress 博客之旅的第一步，说白了，我们不过是把别人已经做好的程序成功的安装到了网上，并且试运行了一下。但博客终究是个讲究个性化的地方，个性化就意味着需要自己动手进行修改。我们的第二步就是对安装好的 Octopress 做个性化修改。<!--more-->

[前面我们说过](http://shengmingzhiqing.com/blog/setup-octopress-with-github-pages.html/)，对于实用性的知识，我向来秉承「精益学习」的态度。对我来说，「如何对一个网站进行个性化修改」正是这类知识，所以我们这篇文章的标题叫做「Octopress 精益修改」。

我们会在使用博客系统的过程中不断发现问题，发现一例解决一例即可，如果一次性发现了很多个问题，可以做一个[任务列表](http://shengmingzhiqing.com/ebauche/octopress/task-list.html)逐一解决。如果遇到暂时解决不了的问题，那么恭喜你，这是你学习的机会，不妨就花一段时间学学相关知识。

当然永远都会出现新的问题，我们的修改过程也就永远不会终止，所以我们的第二步是「永远的第二步」。[^1]

为了行文简化，再说一点：本文中凡出现需要执行的命令，默认使用终端 (Terminal)。如不做特殊说明，请首先使用 <code>cd octopress</code> 命令进 <code>octopress</code> 文件夹，所出现的文件夹或者目录都以此目录为根目录。

## 简要说明

对于博客系统的个性化修改，一般来说分为如下几个方面：

- 新主题安装：Octopress 本身有很多[第三方主题](https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes)可以直接安装使用。
- 基本配置：主要指博客作者，时间显示方式，目录层级关系等等。这部分信息主要通过 <code>_config.yml</code> 这个配置文件来修改。
- 自定义主题模板：主要指顶部导航栏显示内容，侧边栏显示内容等等。这部分内容主要通过 <code>/source/_includes/custom</code> 这个目录下的相关文件来修改。
- 插件安装：安装第三方插件以实现相应效果，比如侧边栏显示 Twitter 时间线等等。 主要与 <code>/plugins</code> 这个目录有关。
- 样式修改：字体，配色等通过样式表修改的属性。主要通过修改 <code>/sass/custom/_styles.scss</code> 来实现。

一般的 Octopress 教程会按照上面的列表分别进行讲解，而我们的修改方式是针对具体问题进行的，同一个问题可能会涉及到以上多方面的修改。这种分类讲解模式可能并不是很方便。所以我会把一些后期基本上不用做太多修改的，类别属性比较明显的放在前面单独讲，之后就按照单个问题来讲解。

## 新主题安装

在你搭建博客的时候，Octopress 会为你安装默认的主题 Classic，但这个主题第一眼看上去很难说好看，所以可以考虑选择安装[第三方主题](https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes)。

如果你能在上面的链接中找到满意的主题，按照主题的要求去安装部署即可。比如你喜欢 [CleanPress](https://github.com/macjasp/cleanpress) 这款主题，你可执行以下命令：

{% codeblock %}
cd octopress
git clone git://github.com/macjasp/cleanpress.git .themes/cleanpress
rake install['cleanpress']
rake generate
{% endcodeblock %}

我个人看过很多主题，但最终还是用了简洁素雅的默认主题。我并不需要太多的装饰[^2]，只要版面布局符合基本审美要求即可。另外，我也喜欢这个浓浓的黑客范儿。

当然默认主题也有很多令人不满意的地方，好在我们还可以修改，不着急，慢慢来。

## 基本配置

### 域名，网站标题，作者

当你打开搭建好的博客后，你会发现博客的标题是 My Octopress Blog，副标题是 A blogging framework for hackers.

当你把第一篇文章发布到博客的时候，你会发现文章底部显示 "posted by Your Name"，也就是说原本应该出现你名字的地方成了系统默认的两个英文单词 "Your Name"。

所有以上这些信息都可以通过基本配置文件 <code>_config.yml</code> 来修改。先在 <code>octopress</code> 文件夹下找到这个文件，用你喜欢的文本编辑器打开（我喜欢 TextMate 2），你会发现如下信息:

{% codeblock lang:yaml _config.yml %}
url: http://yoursite.com  #这里改为你网站的域名
title: My Octopress Blog  #这里改为你想要的网站标题
subtitle: A blogging framework for hackers. #这里改为你的博客副标题
author: Your Name #这里改为博客作者的名字，也就是你的名字
simple_search: https://www.google.com/search #这时默认搜索引擎，可以先不管
description: #网站描述信息
{% endcodeblock %}

按照我给出的 # 后面的提示信息做相应修改即可，请注意，诸如<code>url: </code>中的冒号必须是英文冒号，并且要符合英文标点符号使用规范：冒号后必须空格。

### 日期格式

我们暂且把 <code>_config.yml</code> 文件放到一边，再回头看博客主页，你会发现每条博客上面的日期和文章尾部的日期都是诸如 <code>Apr 28th 2014</code> 这样的格式。我们当然是想把它变成中文的「2014 年 4 月 28 日」这样的格式，那么再次回到 <code>_config.yml</code> 文件，顺着刚才那几行代码往下看，你会发现这样一行：

{% codeblock lang:yaml _config.yml %}
date_format: "ordinal" #默认日期显示方式
{% endcodeblock %}

请把其中的 <code>"ordinal"</code> 改为 <code>"%Y年%-m月%d日"</code>，并保存。

### 文章链接形式

回到博客，点开你发表的文章，这是你看一下地址栏，发现网址（也就是这篇文章的链接）是类似这样的形式：

	http://[your_domain_name]/blog/2014/04/28/Post-Title/

对我们个人博客而言，这种层级显得太多，我个人推荐如下两种地址生成方式：

	http://[your_domain_name]/blog/20140428/Post-Title.html/
	http://[your_domain_name]/blog/Post-Title.html/ # 这也是本博的生成方式

怎么实现呢？接着回到<code>_config.yml</code> 文件，往下看，找到：

{% codeblock lang:yaml _config.yml %}
permalink: /blog/:year/:month/:day/:title/ #文章固定链接
{% endcodeblock %}

按照如下方式修改（二者任选其一）并保存：

{% codeblock lang:yaml _config.yml %}
permalink: /blog/:year:month:day/:title.html/ #实现第一种
permalink: /blog/:title.html/ #实现第二种
{% endcodeblock %}

### 分类目录前缀

在你文章底部日期右边是该文章所属的分类，点击它，会显示该分类下所有的文章[^3]。但你发现该目录标题前有一个前缀 "Categories"，这当然没错，但我们希望它是汉语。

回到<code>_config.yml</code> 文件，添加下面一行代码并保存：

{% codeblock lang:yaml _config.yml %}
category_title_prefix: "分类：" # 修改分类前缀
{% endcodeblock %}

理论上可以添加到任何位置，但为了显示直观，建议加到 <code>category_dir: blog/categories</code> 下一行。

### 「继续阅读」按钮

如果你希望你的文章在首页显示摘要，点击类似「继续阅读」这样的按钮查看全文，可以在你的文章中插入 <code><!--more--></code>，这样在这个标记之前的内容会出现在首页。你可以试着在你的文章中插入这个标签，会发现首页会在这里出现一个<code>Read on &rarr;</code>这样的按钮，当然我们也希望他是汉语。

回到<code>_config.yml</code> 文件，找到这一行：

{% codeblock lang:yaml _config.yml %}
excerpt_link: "Read on &rarr;"  # "Continue reading" link text at the bottom of excerpted articles
{% endcodeblock %}

然后把引号中高亮现实的部分替换为你想要的文字，比如「阅读全文」，并保存。

修改到这一步，你肯定很想看看效果，现在执行如下命令，重新生成并部署页面：

{% codeblock %}
rake generate
rake deploy
{% endcodeblock %}

看看博客，我们想要的效果都已经实现了吧。

### 修改 Markdown 文件后缀

Octopress 默认日志文件后缀是 .markdown，但现在大多数 Markdown 文件的后缀是 .md，推荐使用这种更为简洁的后缀。

用文本编辑器打开 rakefile 文件，找到如下两行行代码：

{% codeblock lang:ruby rakefile %}
new_post_ext    = "markdown"  # default new post file extension when using the new_post task
new_page_ext    = "markdown"  # default new page file extension when using the new_page task
{% endcodeblock %}

改为：

{% codeblock lang:ruby rakefile %}
new_post_ext    = "md"  # 默认新日志文件后缀
new_page_ext    = "md"  # 默认新页面文件后缀
{% endcodeblock %}

第二行是默认新页面文件后缀，如果不明白新页面具体指什么，后面的文章中会有讲解。

### 修改默认 Markdown 解释器

Octopress 默认的 Markdown 解释器是 rdiscount，个人更喜欢 [kramdown](http://kramdown.gettalong.org/quickref.html)，支持 [Multi Markdown](https://github.com/fletcher/MultiMarkdown/wiki/MultiMarkdown-Syntax-Guide)语法和 LaTeX，对于理工科博客 LaTeX 必不可少，而且据说 kramdown 更快，也是 Github 推荐的 Markdown 解释器。

首先用文本编辑器打开 <code>Gemfile</code> 文件，在文件末尾添加一行：

{% codeblock lang:ruby Gemfile %}
gem 'kramdown'
{% endcodeblock %}

然后在终端 (Terminal) 执行如下命令：

{% codeblock %}
sudo bundle install
{% endcodeblock %}

回到<code>_config.yml</code> 文件，找到：

{% codeblock lang:yaml _config.yml %}
markdown: rdiscount
rdiscount:
  extensions:
    - autolink
    - footnotes
    - smart
{% endcodeblock %}

把其中的 <code>markdown: rdiscount</code> 改为 <code>markdown: kramdown</code> 并删掉下面几行。当然如果你想保留原来的代码，以便以后研究，可以考虑把原来这几行代码注释掉（对于  yml 文件，就是在前面加 # ），被注释掉的代码对文件没有任何影响，除了能让你看得更直观之外。[^4]

为了能够显示数学公式，我们需要添加 [MathJax](http://www.mathjax.org) 支持，打开```source/_includes/custom/head.html``` 文件，添加如下代码：

{% codeblock lang:javascript source/_includes/custom/head.html %}
<!-- MathJax -->
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      processEscapes: true
    }
  });
</script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
      tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
      }
    });
</script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Queue(function() {
        var all = MathJax.Hub.getAllJax(), i;
        for(i=0; i < all.length; i += 1) {
            all[i].SourceElement().parentNode.className += ' has-jax';
        }
    });
</script>
<script type="text/javascript"
   src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
{% endcodeblock %}

这样你就可以是所有 LaTeX 语法在网页中输入公式了，比如

$$
f'\left( x\right) = \lim _{x\rightarrow 0}\dfrac {f\left( x+\Delta x\right) - f\left( x\right)}{\Delta x}
$$

上面这个公式的源代码为：

{% codeblock %}
$$
f'\left( x\right) = \lim _{x\rightarrow 0}\dfrac {f\left( x+\Delta x\right) - f\left( x\right)}{\Delta x}
$$
{% endcodeblock %}

每次完成更新都记得把原始文件重新放到 Github 上，还记得命令吧：

{% codeblock %}
git add .
git commit -m "备注内容"
git push origin source
{% endcodeblock %}

至此，我们博客的基本配置告一段落，你可以开始更新你的博客了。当然也许你注意到还有一些瑕疵，比如很多地方还是英文显示，不着急，先把问题记下来，等我Octopress 系列的下一篇文章。

[^1]: 想到这一节，我把博客的副标题也改为了「Hailong Hao's Laboratory」，这里不仅是我的博客，也是用来试错的地方。
[^2]: 这我留给了 <http://haohailong.net/>
[^3]: 当然如果你现在只有这一篇文章，也只会显示这一篇。
[^4]: 你会发现，之前在代码中的说明文字都是注释掉的。