---
layout: post
title: "Octopress 精益修改 (3)"
date: 2014-05-04 11:38:26
comments: true
categories: "Octopress"
---

- list element with functor item
{:toc}

在主题的框架部署完成之后，我们的博客已经可以算是一个五脏俱全的个人网站了，下一步网站变成什么样子，主要看我们往里面加什么样的内容。但在你发表几篇文章之后，你可能就会发现，文字的呈现并不美观，这就需要我们去修改网站和文字的样式。当然，我们必须承认，由于各种各样的原因，同一个网站在不同的操作系统或者不同的浏览器下显示是完全不一样的。作为一个小博客这站长，只能尽我们所能去修改样式，但真的没有精力去保证适应所有的操作系统和所有的浏览器（尤其是 IE）。<!--more-->

本文主要讲网站和文字样式的修改，主要工作就是要修改整个网站的样式表。 Octopress 的样式表放在 <code>sass</code> 目录下。秉承之前谈到的原则，在可能的情况下，我们尽量只修改 <code>sass/custom</code> 这个目录下的内容。

## 1. 网站布局

### 1.1 修改框架宽度

如果说两年多的学术生涯带给我什么对于排版格式方面的收获，那么就是我在使用 LaTeX 的过程中意识到，过宽的布局并不易于阅读。而 Octopress 默认的页面主体框架非常宽，也许对活动颈椎有好处，但我们读起来并不舒服。所以首先我们要缩减默认宽度。

打开 <code>sass/custom/_layout.scss</code> 这个文件，找到如下两行：

{% coderay lang:css sass/custom/_layout.scss %}//$max-width: 1350px;
…
//$sidebar-width-wide: 300px;
{% endcoderay %}

你可以从字面意思看出这两行代码是什么意思，所以你只需要修改相应的数字就好了。以我的博客为例，整体框架的最宽宽度我设为1000px，侧边栏最宽宽度我设为 260px。之所以称为最宽宽度，是因为网站会根据不同的显示设备自适应宽度。其他诸如最窄宽度，中等宽度，你也可以在这个文件中找到相应的代码，进行修改。

修改完之后，记得把这两行前面的 <code>//</code> 去掉，因为在样式表中，这个符号后面的内容默认是注释内容，会被自动忽略。比如，按照我的设置改完之后，这两行应该变为：

{% coderay lang:css sass/custom/_layout.scss %}$max-width: 1000px;
…
$sidebar-width-wide: 260px;
{% endcoderay %}

### 1.2 修改内容宽度

修改完框架宽度之后，我们可以预览一下效果，会发现，由于宽度变窄，文章内容距离框架的边界就显得过宽了，所以我们也要对文章内容的宽度进行修改。同样还是在刚才的 <code>sass/custom/_layout.scss</code> 文件，找到：

{% coderay lang:css sass/custom/_layout.scss %}//$pad-wide: 55px;
…
//$sidebar-pad-wide: 20px;
{% endcoderay %}

这两行定义的是主栏和侧边栏的文字与边框最宽距离，改成你觉得适合的大小即可。当然如果你想修改「中等距离」和「最窄距离」，找到相应代码修改即可。

同样，记得去掉注释符号 <code>//</code> 。

内容宽度设置好之后，我们在插入列表时会发现一个问题：Octopress 的列表符号（或者编号）默认溢出左侧文字内容边界，以保证文字可以对齐。但我们缩小了文字与边框的距离，这样项目符号出现在这里就会显得非常拥挤。建议开启列表缩进功能：在 <code>sass/custom/_layout.scss</code> 中找到 <code>//$indented-lists: true;</code> 去掉注释符号 <code>//</code> 即可。

## 2. 页面字体

布局修改好之后，我们接着来修改文字字体。打开 <code>sass/custom/_font.scss</code> 这个文件，你会发现如下几行代码：

{% coderay lang:css sass/custom/_font.scss %}//$sans: "Optima", sans-serif;
//$serif: "Baskerville", serif;
//$mono: "Courier", monospace;
//$heading-font-family: "Verdana", sans-serif;
//$header-title-font-family: "Futura", sans-serif;
//$header-subtitle-font-family: "Futura", sans-serif{% endcoderay %}

由上至下定义了「衬线字体」「无衬线字体」「等宽字体」「标题字体」「网站主标题字体」「网站副标题字体」，在其中添加你喜欢的字体即可。字体的优先级是由先到后的。当然别忘了去掉注释符号。

对于英文字体，你还可以去 [Google Webfonts](http://www.google.com/fonts/) 查找你喜欢的字体并使用，比如你想用 PT Serif 这个字体，你只需要在 <code>source/_includes/custom/head.html</code> 中添加如下代码即可：

{% coderay lang:html source/_includes/custom/head.html %}
<link href="//fonts.googleapis.com/css?family=PT+Serif:regular,italic,bold,bolditalic" rel="stylesheet" type="text/css"> {% endcoderay %}

顺便说一句，对于中文字体，为了照顾 Windows 用户，我们不得不在 font-family 中添加「微软雅黑」，因为一般人电脑里都会有。尽管这个字体并不好看，但其他 Windows 自带字体更难看。

字体选好之后，我们还需要调整不同文字字体的大小。这部分内容是在 <code>sass/base/_typography.scss</code> 这个样式表中定义的。注意它并不在 <code>sass/custom</code> 目录下。打开之后，你会看到对于不同内容字体样式的定义，比如：

{% coderay lang:css sass/base/_typography.scss %}body > header h1 {
  font-size: 2.2em;
  @extend .heading;
  font-family: $header-title-font-family;
  font-weight: normal;
  line-height: 1.2em;
  margin-bottom: 0.6667em;
}{% endcoderay %}

这部分定义的是一级标题的字体样式，其中 <code>font-size: 2.2em</code> 即为字体大小。其他文字的字体大小定义方式也与此类似。你可以直接修改这里的数字来更改文字大小，但秉承我们之前的原则，我们并不修改这个文件。复制 <code>sass/base/_typography.scss</code> 当中想要修改的部分，粘贴到 <code>sass/custom/_styles.scss</code> 这个文件中，然后在 <code>_sytle.scss</code> 这文件中修改即可生效。

这里顺便讲讲 Octopress 的样式表。其实真正定义最终呈现在页面上的效果的样式表是 <code>sass/screen.scss</code> 这个文件，打开之后你会发现：

{% coderay lang:css sass/screen.scss %}
@import "compass";
@include global-reset;

@import "custom/colors";
@import "custom/fonts";
@import "custom/layout";
@import "base";
@import "partials";
@import "plugins/**/*";
@import "custom/styles";{% endcoderay %}

几乎全文件都是 @import 语句，我们可以从字面意思猜出这个语句的意思。也就是说，我们修改的那些样式表，最终会导入这个样式表，然后实现对样式的改动。

如果你想新定义一些样式，事实上也可以新建一个样式表，然后在这里添加@import 语句导入 <code>sass/screen.scss</code> 即可。当然本身 @import 语句也可以嵌套，你甚至可以把你自己新建的样式表导入 <code>sass/custom/_styles.scss</code>，最终你的样式设置也会导入到 <code>sass/screen.scss</code>，因为 <code>sass/custom/_styles.scss</code> 本身也被导入了 <code>sass/screen.scss</code> 当中。这样无论我们定义什么样式，都可以只修改 <code>sass/custom</code> 目录中的内容。[^1]

## 3. 修改链接样式

Octopress 默认超链接显示样式有下划线，对于中文来说，这条下划线会和文字挤在一起，不甚美观。打开 <code>sass/base/_theme.scss</code> 文件，找到这行代码：

{% coderay lang:css sass/base/_theme.scss %}
a {
  @include link-colors($link-color, $hover: $link-color-hover, $focus: $link-color-hover, $visited: $link-color-visited, $active: $link-color-active);
}
{% endcoderay %}

在花括号中添加一行 <code>text-decoration: none; </code> 。当然也可以把这段代码复制到 <code>sass/custom/_styles.scss</code> 中再做相应修改。

所有有关链接样式的修改，都只需要在相应的样式表中找到 <code>a { }</code> 这样的代码，修改花括号里面的内容即可。

## 4. 给中英文间添加空格

锤子科技的 UX 产品总监[@朱萧木](http://weibo.com/u/1842158375) 老师前一段时间发了一条微博：

> 打字时，中英混排时，中文和英文之间应该空一格，这一格，就是逼格。  
> [4月10日 00:09](http://www.weibo.com/1842158375/AEWZGogNT)

很多朋友看完之后，并不明白他到底是什么意思，那么为什么要在中英文间加空格呢？首先，这样确实要好看一些；其次，对于网页显示来说，如果中英文间不加空格，默认会把这个英文单词和它前后的汉字当成一个单词，所以不会再汉字和英文之间换行，如果有采用了两段对齐的格式，很有可能出现某行文字过于稀疏的问题，整体上依然不美观。

但我们在书写中文的时候，其实并没有在汉字之间加空格的习惯，如果文字中偶尔出现英文，像我这样的强迫症都不是每次都记得空格。那么该如何解决这个问题呢？如果你用过 Word，你会发现在中英文之间，会自动保持一点距离，也就是说软件设计者自动实现了中英文间的空格，并不需要我们在打字时额外留意。

考虑到朱萧木老师的身份，我给他做了如下的回复：

> 朱老师，作为一个贴心的产品经理，这一格不应该默认加在手机系统中么？参考<http://t.cn/zOWs207>  
> [4月10日 02:00](http://www.weibo.com/1645866217/AEXIFwGEZ)

注意我给他的参考链接，正是在 Octopress 下的实现方式，来自[肖之慰的博客](http://xoyo.name)。参考他这篇《[给中英文间加个空格](http://xoyo.name/2012/04/auto-spacing-for-octopress/)》，你可以实现像本博客一样的中英文自动空格。

[^1]: 当然有些时候，一些插件的样式表放到 <code>sass/plugins</code> 目录下似乎更合逻辑。