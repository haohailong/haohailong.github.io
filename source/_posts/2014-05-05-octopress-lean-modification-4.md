---
layout: post
title: "Octopress 精益修改 (4)"
date: 2014-05-05 16:52:14
comments: true
categories: "Octopress"
---

- list element with functor item
{:toc}

## 1.  CodeRay Block 代码块插件

用 Octopress 写博客的很多朋友需要在博客内容当中添加代码块，毕竟这是一个「为黑客而生的博客框架」。Octopress 除了可以使用 Markdown 语言默认的代码块实现方式之外，本身也集成了很强大的代码块 (Code Block) 插件，按照[官方的说明](http://octopress.org/docs/plugins/codeblock/)调用即可，比如：

{% codeblock lang:python 节选自比特币 Python API %}
rv = conn.validateaddress(foo)
if rv.isvalid:
    print "The address that you provided is valid"
else:
    print "The address that you provided is invalid, please correct"
{% endcodeblock %}

官方的 Code Block 插件支持语法高亮，本身的显示效果也非常不错，可以与博客大背景的深色形成呼应。但如果你的文章中出现大量的代码块，黑色背景看起来可能不那么舒服。这时，你可能想要使用浅色系的代码块，比如：

{% coderay lang:python 节选自比特币 Python API %}
rv = conn.validateaddress(foo)
if rv.isvalid:
    print "The address that you provided is valid"
else:
    print "The address that you provided is invalid, please correct"
{% endcoderay %}

最早看到这种风格的显示是在 [Kat Hagan 的博客](http://blog.codebykat.com/2013/05/23/gorgeous-octopress-codeblocks-with-coderay/)，她在文章中介绍了一种新的语法高亮工具——[CodeRay](http://coderay.rubychan.de)，使用这种工具即可实现上面浅色圆角的代码块。作者同时也是一位极具分享精神的 Web 开发者，为了方便大家使用 CodeRay，她还专门制作了一个非常方便安装的 Octopress 插件。

但是她这个插件取消了 CodeRay 自带的行号功能，在当你需要指出某一行代码时，就非常不方便。为了解决这个问题，[Jan Stevens](http://www.fritz-hut.com/2013/11/24/github-style-code-highlighting-for-octopress/) 在 Kat 的插件基础上，开发了可以添加行号的 CodeRay 插件，但为了适应他自己博客的风格，同时也写了新的样式表。

由于 Kat 用的是 Octopress 默认主题，从总体风格上而言，Kat 的插件样式更适合我们的博客，于是我尝试着用 Kat 的样式表配合 Jan 的插件使用，在在代码块没有标题框 (Caption) 的情况下表现完美。但一旦加上标题框，问题就出现了：代码块主体部分与标题框的连接处出现了不必要的圆角，显得非常难看。为了解决这一问题，我在他们的基础上修改了 Coderay Block 插件，如果你需要，在这里：[Octopress CodeRay Block](http://s.olo.la/iqLp).

具体安装和使用方法如下：

### 1.1 安装 kramdown, CodeRay

首先你需要在你的博客程序中安装 kramdown 和 CodeRay（如果你已经安装过，则可以跳过此步）：

在 ```Gemfile``` 中添加如下两行代码：

{% coderay lang:ruby %}
gem 'kramdown'
gem 'coderay'
{% endcoderay %}

在终端执行如下命令：

{% coderay lang:ruby %}
bundle install
{% endcoderay %}

然后修改 ```_config.yml``` 文件中相关内容如下：

{% coderay lang:yml  _config.yml %}
markdown: kramdown
kramdown:
    use_coderay: true
    coderay:
        coderay_line_numbers: table
        coderay_css: class
{% endcoderay %}

其中 ```coderay_line_numbers: table``` 表示激活 CodeRay 的行号功能。

### 1.2 修改样式表

把 ```/sass/custom/_coderay.scss``` 文件复制到你自己的 ```/sass/custom/``` 文件夹下。

把 ```/sass/custom/_styles.scss``` **文件中的代码**添加到你自己的 ```/sass/custom/_styles.scss```文件夹中。

安装完成。

### 1.3 使用方法

{% coderay lang:ruby %}{% raw %}
{ % coderay [lang:lang] [linenos:true|false(default)] [title] [url] [link text] % }
代码片段
{ % endcoderay % }{% endraw %}
{% endcoderay %}

你可以看到这个使用方法与官方的 CodeBlock 插件非常像，其中：```lang:``` 定义了代码的语言，```linenos:``` 定义了是否显示行号（默认不显示），```title``` 是代码框标题，```url``` 是链接，```link text``` 是链接文本。

## 2. 给图片添加标题 (Caption)

在我们发布文章的时候，难免会插入图片。你可以把你想插入的图片（比如 dream.jpg）放到 ```source/images/``` 文件夹下。重新生成部署站点之后，图片的地址为 ```{% raw %}{{ root_url }}/source/images/dream.jpg{% endraw %}```，当然你也可以给 images 文件夹下再添加其他文件夹，只要你加到图片最终的路径上即可。

具体使用图片时，官方自带了图片插件 (Image Tag)，使用非常方便，具体方法可以参考[官方说明](http://octopress.org/docs/plugins/image-tag/)。但有时候，我们需要给图片添加标题 (Caption)，比如在我的文章「[为什么「Enter 键」要被翻译为「回车键」？](http://shengmingzhiqing.com/blog/why-enter-key-is-huiche-in-chinese.html/)」中的第二张图。这时官方的插件就显得不够用了，如果你也需要这样的功能，请参照 [*Image Captions for Octopress*](http://blog.zerosharp.com/image-captions-for-octopress/) .

## 3. 使用 FontAwesome

装饰网站和撰写文章，不可避免的要使用到一些 Logo 和图标，对于一个非设计专业人士来说，该如何轻松获取图标呢？这里有一个巨大的图标库 [Font Awesome](http://fortawesome.github.io/Font-Awesome/icons/)，事实上，我博客导航栏和侧边栏使用的 Logo 就来自 Font Awesome.

要使用 Font Awesome，你只需要简单地在 ```source/_includes/custom/head.html``` 中添加如下一行代码：

{% coderay lang:html source/_includes/custom/head.html http://fortawesome.github.io/Font-Awesome/get-started/ %}
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
{% endcoderay %}

安装工作就完成了。然后你看中哪个 Logo，直接输入官方的 Logo 代码，就可以让 Logo 出现在页面相应位置。比如你想显示照相机的 Logo：

{::nomarkdown}
<i class="fa fa-camera-retro fa-5x"></i>
{:/nomarkdown}

你只需要输入如下代码：

{% coderay %}
<i class="fa fa-camera-retro fa-5x"></i>{% endcoderay %}

有时候 Font Awesome 可能会出现与 kramdown 解析器相冲突的情况，导致全局样式发生变化，这是你只需要在 Logo 的代码前后分别添加 ```{% raw %}{::nomarkdown}{% endraw %}``` 和 ```{% raw %}{:/nomarkdown}{% endraw %}```强制 kramdown 不去解析这段语句即可，比如上面的代码可以改为：

{% coderay %}{% raw %}
{::nomarkdown}
<i class="fa fa-camera-retro fa-5x"></i>
{:/nomarkdown}{% endraw %}{% endcoderay %}