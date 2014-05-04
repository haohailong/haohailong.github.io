---
layout: post
title: "Octopress 精益修改 (2)"
date: 2014-05-04 03:41:14
comments: true
categories: "Octopress"
---

通过前面的教程，我们成功搭建起了自己的 Octopress 博客，并对博客框架做了基本配置。这已经可以算是一个真正意义上的个人博客了：1. 确实可以在互联网上看到；2. 文章有自己的署名；3. 甚至可以撰写有公式的科技文章。

但我们对于网站的个性化修改并没有结束：首先，网站整体显得很粗糙，很多必要的信息，比如作者简介，并没有呈现；其次，虽然我们对基本配置中涉及到的部分做了有限的汉化，但也正因为我们做了部分汉化，其余的英文部分显得更加不伦不类。针对这些问题，本文将继续我们「精益修改」之路。

在正式进入主题之前，先给大家一个小技巧：我们可以先在终端执行命令 <code>sudo rake preview</code>，然后使用 <code>http://localhost:4000/</code> 这个网址对我们的网站进行预览。然后我们再修改相关属性，在修改过程中，只要刷新页面就可以看到实时效果，等效果没有问题了，我们再执行 <code>sudo rake generate</code> 和 <code>sudo rake deploy</code> 发布到网络上。[^1]当然，最后还要记得使用 git 命令把修改后的源文件传到 Github 上。

## 1. 页面相关设置

### 1.1 新建页面

对于一个博客来说，仅仅有按时间发布的文章或日志是不够的，我们还需要在上面放一些其他页面。对于 Octopress 来说，系统默认只有两个页面，一个是 Blog 页面，上面按照时间顺序显示着我们发布的日志，另一个是 Archives (归档) 页面，也是我们的文章列表，只是用一种更为简洁的方式呈现，只有标题，时间，和分类描述。

但仅有这两个页面对很多人来说并不够，我们需要更多，比如在我的博客中，还有一个「[系列文章](http://shengmingzhiqing.com/article-series/)」页面，里面放的是我成系列的文章，更加方便读者阅读，也方便自己查阅。那么像这样一个页面该如何生成呢？很简单，执行以下命令：

{% coderay %}
sudo rake new_page[your-title]
{% endcoderay %}

然后你会发现，在你 <code>source</code>  文件夹下会出现一个名为 <code>your-title</code> 的文件夹，里面会有一个名为 index.md 的文件。还记得我们在「[精益修改 (1)](http://shengmingzhiqing.com/blog/octopress-lean-modification-1.html/#markdown-)」中修改过 rakefile 里的 Markdown 文件的 后缀，其中有一行是 <code>new_page_ext</code>，这里改动的正式新页面的后缀。

在你重新部署后，这个文件将会生成一个名为<code>index.html</code> 的文件。可以用以下链接来访问这个页面：

{% coderay %}
http://[your_domain]/your-title/
{% endcoderay %}

当然如果你现在访问的话，页面的标题将会是 "your title"，而内容是空白，这简直太合理了，因为我们真的就什么都没写。

那么该怎么修改页面的内容呢？不用我说你也知道，只要修改那个 <code>your-title</code> 文件夹下的 index.md 文件即可，具体方法和修改文章一样，在此我不再赘述。

当然有时候我们并不想让每个页面都生成一个新的文件夹，那么你可以考虑执行以下命令：

{% coderay %}
sudo rake new_page[your-title/mylove.html]
{% endcoderay %}

这样你将在 <code>your-title</code> 文件夹下生成一个 mylove.html 的文件，部署后即可用以下地址访问：

{% coderay %}
http://[your_domain]/your-title/mylove.html
{% endcoderay %}

当你打开这些新页面文件的时候，你会发现和新文章类似的元数据：

{% coderay lang:markdown linenos:true %}---
layout: page
title: "your-title"
date: 
comments: true
sharing: true
footer: true
---{% endcoderay %}

如果你想让页面显示作者，可以在中间加一行 <code>author: </code> 后面接作者名字即可。顺便说一说第一行的 <code>layout: </code> 属性，指的是这个页面用什么样的布局来显示。比如这里是页面布局，之前我们发的文章是 post 布局。具体什么布局是什么样子，通过 <code>source/_layout</code> 这个文件夹下的文件来定义。如果你有一点点模仿能力，你可以根据里面已有的文件，设计出自己的布局。

和生成新文章一样，你可以自己在相应的文件夹下新建 Markdown 文件来生成相应的页面，并不是一定要用命令行的方式实现。当然，记得要给文件添加上面的元数据。

## 1.2 添加公益 404 页面

对于一个网站来说，有一个页面我们很少会注意到，那就是这个网站的 404 页面——当网站找不到用户访问的页面（通常是不存在）时的替代页面。

这个页面对我们来说并不重要，但却是经常被访问到的页面之一。很多聪明人就想到了这一点：我们可以用它来做公益。你可以试着访问以下我的404页面：<http://shengmingzhiqing.com/404>，你会发现一条寻人的公益广告。那么这是如何实现的呢？

首先在 <code>source</code> 文件夹下新建一个 404.md 页面文件，然后到 <http://notfound.org/> 这里复制粘贴相应的代码即可。

当然如果你更愿意用中文的产品，可以考虑益云的公益404项目，我的[另一个博客](http://haohailong.net/)用的就是这个方案。不过益云生成的页面并不是响应式设计[^2]，所以手机浏览效果比较差。

## 1.3 添加页面和其他链接至导航栏

我们现在知道了新页面的生成方式，知道了页面生成后的链接，你可以通过这个链接来访问，但你博客的读者却并不知道这个页面在哪里，因此我们需要给他一个快速找到这个页面的方式，毕竟我们不能把所有的页面都当成404页面。

你可以直接把链接放到文章中，和你插入别的超链接的方式没有任何区别。但很多时候我们会把一些重要页面的链接放在导航栏：

首先，请打开<code>source/_includes/custom/navigation.html</code> 这个文件，你会看到：

{% coderay lang:html linenos:true source/_includes/custom/navigation.html %}{% raw %}<ul class="main-navigation">
  <li><a href="{{ root_url }}/">Blog</a></li>
  <li><a href="{{ root_url }}/blog/archives">Archives</a></li>
</ul>{% endraw %}{% endcoderay %}

这里就是导航栏里所有链接的列表，你只需要依样画葫芦即可完成页面添加。比如你想把刚刚生成的 your-title 页面和 mylove 页面添加到导航栏中，你可以在第三行下面再加如下两行：

{% coderay lang:html linenos:true source/_includes/custom/navigation.html %}{% raw %}  <li><a href="{{ root_url }}/your-title/">your-title</a></li>
  <li><a href="{{ root_url }}/your-title/mylove.html">mylove</a></li>{% endraw %}{% endcoderay %}

当然，我们也可以顺手汉化系统默认的两个页面，只要你把上面的 <code>Blog</code> 和 <code>Archives</code> 分别修改成你想要的信息，比如「首页」和「文章列表」，即可像本博客这样显示。

你也可以在这里添加站外链接，只需要把 <code>a href</code> 后面引号中的部分改为相应的网站链接即可。

有一点需要说明，这里出现的 {% raw %}<code>{{ root_url }}</code>{% endraw %} 是你网站的根目录，一般而言就是你的主域名。比如对于我这个博客来说，只要这个链接在站内：{% raw %}<code>{{ root_url }}/page.html</code>{% endraw %} 和 <code>http://shengmingzhiqing.com/page.html</code> 是一个意思。前者给出的是 page.html 相对于根目录的路径，后者给出的是在 <code>shengmingzhiqing.com</code> 这个目录下的路径。简单来说，前者是页面的相对路径，后者是页面的绝对路径。

一般而言，站内连接的使用原则是，能使用相对路径就不要使用绝对路径。 因为域名一旦变更，相对路径继续有效，绝对路径将依然指向原域名下的页面，这本来就不是我们的本本意，而如果原来的域名废弃了，链接将直接失效。最为直接的影响是，如果我们在一个指向页面的超链接中使用了绝对路径，我们本地预览页面中的链接与已经部署到网络上的页面链接将指向相同的内容，这样我们就无法通过这个已经设好的超链接来追踪页面的实时效果。

在本文后面的部分以及后面的文章中，我将使用 {% raw %}<code>{{ root_url }}</code>{% endraw %} 来代替你网站的根目录（域名）。

## 2. 主题汉化

之前在设置各种属性的时候，我们已经顺手汉化了一些内容，本节将继续其余的汉化工作。之所以到现在才系统性地对主题进行汉化，是因为通过前面的设置和修改，与博客相关的基本内容都已经呈现在了我们面前，这样我们可以一次性把所有的需要汉化的内容都做好。

### 2.1 汉化导航栏

我们刚刚已经顺手汉化了导航栏左侧的页面链接，现在剩下的是导航栏右侧的搜索框和 RSS 订阅链接。这部分内容在 <code>source/_includes/navigation.html</code> 文件中，注意文件路径，与刚才我们修改的 navigation.html 文件不是一个文件。

在这里顺便说一句，通常只主张修改 <code>custom</code> 目录下的内容，因为这部分内容会覆盖掉主题默认的内容，这样可以在不影响原主题代码的情况下，完成我们想要的效果，同时保证了即使我们自己写的代码有问题，系统也有一个默认的代码可以执行。当然对于我们的汉化工作来说，这样不会有太大影响。
{:.warning}

打开之后找到如下两行代码：

{% coderay lang:html %}<li><a href="{{ site.subscribe_rss }}" rel="subscribe-rss" title="subscribe via RSS">RSS</a></li>
  …
<input class="search" type="text" name="q" results="0" placeholder="Search"/>{% endcoderay %}

把其中的 "subscribe via RSS" 和 "Search" ("pacehoder=" 后面那个) 分别换成「订阅 RSS」和「搜索」即可。

### 2.2 汉化移动设备导航栏

Octopress 默认采用了响应式设计，也就是说会根据不同的浏览器和浏览工具自动调节页面显示效果。当你用非常窄的工具（比如手机）浏览时，导航栏会缩为一个下拉菜单，默认内容是 navigation…，要修改这个内容，请打开 <code>source/javascripts/octopress.js</code> 文件，把第四行的 navigation 改为「网站导航」即可。

### 2.3 汉化归档页面

汉化完导航栏之后，我们打开归档页面 ({% raw %}http://{{ root_url }}/blog/archives{% endraw %})，你会发现这个页面上的日期和分类 (Posted in) 还是用英文显示的。要汉化这个内容，我们应该找到相应的页面文件。

不妨根据我们刚才新建页面时对目录的理解，推测一下它在哪个目录。没错，它应该是在 <code>source/blog/archives</code> 目录下的 <code>index.html</code> 文件。但我们打开这个文件之后，发现并没有日期和分类这两项，不过不要着急，仔细观察，你会发现页面的主体内容部分被如下一句代码所代替：

{% coderay %}{% raw %}{% include archive_post.html %}{% endraw %}{% endcoderay %}

也就是说，真正出现文字的地方应该在 <code>archive_post.html</code> 这个文件中。那么哪里去找这个文件呢？你当然可以用搜索功能，但在这里，为了更好的了解目录结构，不妨再推测一下。<code>archive_post.html</code> 前面有个 <code>include</code>，通常用这个命令包含的网页，都在 <code>source/_include</code> 这个目录下。打开这个目录，你果然找到了 <code>archive_post.html</code> ，打开之后会找到如下两行代码：

{% coderay lang:html %}{% raw %}
<time datetime="{{ post.date | datetime | date_to_xmlschema }}" pubdate>{{ post.date | date: "<span class='month'>%b</span> <span class='day'>%d</span> <span class='year'>%Y</span>"}}</time>
…
<span class="categories">posted in {{ post.categories | category_links }}</span>{% endraw %}
{% endcoderay %}

分别做如下替换："%b" →「%m月」；"%d" →「%d日」；"posted in" →「分类：」。

### 2.4 汉化侧边栏

归档页汉化完之后，朝右看你会发现侧边栏有个 Recent posts，你当然明白是什么意思，但你更希望这个标题是汉语。

Octopress 所有侧边栏页面都在 <code>source/_includes/asides</code>文件夹下，在这里你找到 <code>recent_posts.html</code> 这个文件。将其中的 <code>Recent posts</code> 改为 <code>最新文章</code> 即可。

如果以后添加了其他的侧边栏，也通过同样的方式来汉化。

### 2.5 汉化其他部分

当你完成上面三步的时候，整个网站汉化工作基本上已经完成了，只是以后你可能会在添加其他内容，这是可能又需要重复一些汉化工作。那么该如何进行呢？

对于系统或主题已有的一些组件：

1. 如果要汉化页面，那么按照页面生成的规范找到页面源文件修改即可；

2. 如果出现 include 这样的语句，后面的文件一般会出现在 <code>source/_include</code> 目录下，当然也包括这个目录下的子目录，比如 <code>source/_include/custom</code> 目录；

3. 如果要汉化侧边栏，一般去 <code>source/_include/asides</code> 目录寻找相应文件；

4. 如果上述方式都无法找到文件，请在 <code>source</code> 文件夹下针对关键字搜索。

如果是新安装的插件：

1. 首先在新添加的文件中查找；

2. 如果上述方式都无法找到文件，请在 <code>source</code> 文件夹下针对关键字搜索。

以上的方法几乎可以解决所有和页面内容有关的问题，而不仅仅是汉化问题。

## 3. 网站底部

一般来说网站底部会有一些网站的描述信息，比如版权声明，网站主题，网站使用的系统等等，要修改这部分内容，直接打开 <code>source/_includes/custom/foot.html</code>修改相应部分即可。

## 4. 添加侧边栏

我们刚刚说过，所有的侧边栏页面都在 <code>source/_include/asides</code> 目录下，我们可以把我们想要的侧边栏工具放到这里。系统自带了一些侧边栏小工具，比如我们刚刚已经看到的 Recent posts。

如果我们想让系统自带的这些侧边栏工具显示出来的话，需要在 _config.yml 文件下作相应的设置。比如你想添加 pinboard 的小工具，在 _config.yml 中找到如下代码做相应修改即可：

{% coderay lang:yml %}
# Pinboard
pinboard_user: #在这里添加你的 pinboard 用户名
pinboard_count: 3 #这里的数字是默认现实的 pinboard 书签数量，可以任意修改
{% endcoderay %}

还有一行代码需要注意：

{% coderay lang:yml %}
default_asides: [asides/recent_posts.html, asides/github.html, asides/delicious.html, asides/pinboard.html, asides/googleplus.html]
{% endcoderay %}

这行代码中，后面给出的页面文件，都是默认显示在侧边栏的小工具，只要你进行了类似上面对 Pinboard 工具的设置，就会出现在侧边栏上。前后顺序代表了出现在侧边栏上的上下顺序，你可以根据需要做相应的修改。

如果你自己要添加新的侧边栏工具，也需要把文件目录加到这个列表中。

一般而言自行添加的侧边栏工具建议放到 <code>source/_include/custom/asides</code> 这个目录下。你会看到这个目录下主题默认已经有了 <code>about.html</code>，你可以直接修改此文件（包括汉化）来生成「关于」侧边栏。生成完之后，需要把 <code>custom/asides/about.html</code> 添加到上面的列表中，注意这个列表中的路径都是想对于 <code>source/_include/</code> 目录的路径。

## 5. 添加评论系统

到目前为止，我们都忽略了一个博客系统非常重要的组成部分，就是与读者的互动。这需要我们加入一个评论系统。Octopress 默认支持 Disqus 评论系统，你需要先到 disqus.com 注册一个账号。然后在 _config.yml 中找到：

{% coderay lang:yml %}
# Disqus Comments
disqus_short_name: 
disqus_show_comment_count: false {% endcoderay %}

填入相关信息即可。

很多人会说 Disqus 评论系统在中国水土不服，如果你也是这样的观点，网上也有许多安装「多说」和「友言」评论系统的教程可供参考。对于我个人而言，我更愿意用 Disqus，毕竟这个博客是我的一个实验室，我愿意尝试原来的博客不一样的东西。

目前 Disqus 的提示文字并不支持简体中文，鉴于这一情况，我推荐你使用英文或者繁体中文作为评论框的提示语言。根据 Disqus 官方的一些说明，将会在不久的将来支持简体中文，到时候再切换也不迟。

你可能会惊讶于能在我的博客上看到简体中文的 Disqus 评论框，其实是这样的，Disqus 的旧版是支持简体中文的，新版的简体中文翻译工作正在进行，但他们并没有把简体中文的选项在系统中彻底抹去，可以通过审查元素的方式把这个选项调出来。但毕竟翻译没有完成，可能会在夹杂一些英文在系统当中，所以除非你像我一样想折腾一下，否则并不建议使用。

[^1]: 这个技巧对主题和样式的修改有效，但对于一些插件，实现效果可能需要重新生成页面，并重新部署。不过总的来说这个预览功能非常实用。

[^2]: 不要被这个唬人的术语吓住，其实就是原来的自适应设计的新名字。