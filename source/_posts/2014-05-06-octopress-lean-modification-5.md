---
layout: post
title: "Octopress 精益修改 (5)"
date: 2014-05-06 10:31:11
comments: true
categories: "Octopress"
---

- list element with functor item
{:toc}

## 1. 侧边栏显示分类目录

随着文章数量的增多，为了更方便检索，我们需要对文章进行整理。整理的方式一般分为两种：1. 「分类目录」，这是一种收敛式的整理方式，也是 Octopress 的默认方式；2. 「标签」，这是一种扩散式的整理方式，使用这种方式的典范是 [Tumblr](http://www.tumblr.com) 轻博客。

对我个人而言，搭建这个新博客主要是为了存放自己撰写的与理工（目前看来是 IT 和经济学）相关的文章，主题比较收敛，本身文章也不多，所以采用了 Octopress 默认的「分类目录」整理方式。<!--more-->

但我们的目的是方便检索，仅仅给每篇文章设置分类还不够，还需要专门找个地方显示分类列表。由于 Wordpress 的习惯，我更愿意把分类目录放到侧边栏显示。那么该如何实现这一功能呢？在自己动手写代码之前，先看看有没有巨人的肩膀可以踩是个非常好的习惯。Google 之后，我们找到这样一篇文章：《[为octopress添加分类(category)列表](http://codemacro.com/2012/07/18/add-category-list-to-octopress/)》。参考这篇文章的方法，具体实现步骤如下：

首先，用如下代码新建文本文件，另存为 ```category_list_tag.rb```，并把这个文件放到 ```plugins``` 目录下。

{% coderay lang:ruby plugins/category_list_tag.rb %}
module Jekyll
  class CategoryListTag < Liquid::Tag
    def render(context)
      html = ""
      categories = context.registers[:site].categories.keys
      categories.sort.each do |category|
        posts_in_category = context.registers[:site].categories[category].size
        category_dir = context.registers[:site].config['category_dir']
        category_url = File.join(category_dir, category.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase)
        html << "<li class='category'><a href='/#{category_url}/'>#{category} (#{posts_in_category})</a></li>\n"
      end
      html
    end
  end
end

Liquid::Template.register_tag('category_list', Jekyll::CategoryListTag){% endcoderay %}

然后我们使用如下代码新建 ```category_list.html``` 文件，并放到 ```source/_includes/custom/asides/``` 文件夹下。

{% coderay lang:html source/_includes/custom/asides/category_list.html %}{% raw %}
<section>
  <h1>Categories</h1>
  <ul id="categories">
    {% category_list %}
  </ul>
</section>{% endraw %}{% endcoderay %}

最后，我们在 ```_config.yml``` 文件中 ```default_asides:``` 后面的方括号中，添加一项 ```custom/asides/category_list.html```，放到你喜欢的位置。

这样我们就可以在侧边栏看到分类目录列表了。不过且慢，每个功能实现之后，我们还是测试一下为好。如果你的分类名称中有中文，你就会发现这个链接并不能正确指向该分类的页面，那么该怎么办呢？

打开 ```plugins/category_list_tag.rb```，找到如下一行代码：

{% coderay lang:ruby plugins/category_list_tag.rb %}
html << "<li class='category'><a href='/#{category_url}/'>#{category} (#{posts_in_category})</a></li>\n"
{% endcoderay %}

替换为：

{% coderay lang:ruby plugins/category_list_tag.rb %}
html << "<li class='category'><a href='/blog/categories/#{category.to_url.downcase}/'>#{category} (#{posts_in_category})</a></li>\n"
{% endcoderay %}

完工。

## 2. 自动生成文章目录

博客文章不想报纸杂志，自然有长有短：短文章可以短到只有标题，而长文章往往会分为好多个章节。为了方便阅读，我们往往会把一篇长文章分为好几篇来发布，比如我们的「Octopress 精益修改」，但即便如此，有些文章还是会超出最适宜阅读的长度，同样比如我们这个 Octopress 教程。那么有没有什么办法能够解决这个不宜阅读的问题呢？

我们知道，使用 Markdown 语言撰写的文章，只要你把章节题目标清楚，本身会生成一个内在的文档结构，如果我们直接把这个结构提取出来，作为文章的目录，放到文章开头，这样就能一举解决我们刚才所说的问题。那么有没有这样的实现方式呢？带着这个问题，我们找到了这样一篇文章：[*Table Of Contents in Octopress*](http://blog.riemann.cc/2013/04/10/table-of-contents-in-octopress/)，参考此文，具体实现步骤如下：

首先，请使用 kramdown 作为 Octopress 默认的 Markdown 解析器，具体如何设置请参照先前的教程。

然后只要你在想插入目录的地方，插入如下一段代码即可：

{% coderay %}{% raw %}
* list element with functor item
{:toc}{% endraw %}
{% endcoderay %}

没错，就这么简单。当然你可能希望能在这个目录前面自动添加，类似本文前面的「本页目录」四个字，只需要修改样式表 ```sass/custom/_style.scss```，添加如下代码：

{% coderay sass/custom/_style.scss %}
#markdown-toc:before {
  content: "本页目录";
  font-weight: bold;
}{% endcoderay %}

最后，可能还有一个问题，有些朋友和我一样会在文章中使用 ```{% raw %}<!-- more -->{% endraw %}``` 标签，在首页只显示部分文章，这时这个目录生成可能就会出现错误，而且事实上我们也没必要在文章的摘要中放置一个目录，所以我们可以在 ```sass/custom/_style.scss``` 添加如下代码，让主页不出现目录：

{% coderay sass/custom/_style.scss %}
.blog-index #markdown-toc {
  display: none;
}{% endcoderay %}

如果你对这个目录的样式不满意，还可以在样式表中进一步修改，改成什么样就看你个人喜好了。

## 3. 自动添加文章修改记录

[前面我们说过](http://shengmingzhiqing.com/blog/setup-octopress-with-github-pages.html/#octopress--github-pages)，写文章，建网站都难免要修改，而且会反复修改。如果能把这些修改过程记录下来，本身就是很好的学习资料，那么有没有办法实现这一点呢？Git 就是干这个的，而且也正是我们前面说的 Octopress + Github Pages 相比其他博客系统的优势之一。

事实上，我们每一次更新文章后提交至 Github 的 Commit 就可以当做是文章的修改记录和说明，如果我们能让这个信息自动出现在文章末尾，就可以实现我们想要的功能。同样，百事未行先 Google，我们发现了这样一篇文章：[*Post Revision Plugin for Octopress*](http://jhshi.me/2013/11/17/post-revision-plugin-for-octopress/)，参考此文，具体实现步骤如下：

1. 到这里 <http://s.olo.la/a6cM> 找到 Octopress Post Revision 插件。

2. 复制 ```plugins/revision.rb``` 到你自己的 ```plugins``` 目录下。

3. 复制 ```source/_includes/post/revision.html``` 到你自己的 ```source/_includes/post``` 目录下。

4. 在 ```_config.yml``` 文件中，添加你的 Github 账户信息，如下： <br /><br />
{% coderay lang:yml _config.yml %}
github_user: # 这你填你的 Github 用户名
github_repo: # 这里填你博客的库名，即 [your_user_name].github.io
{% endcoderay %}<br /><br />
5. 在 ```source/_layouts/post.html``` 的 ```<footer>``` 和 ```</footer>``` 之间，你想要的位置，添加如下代码，此处即为文章修改记录的显示位置：<br /><br />
{% coderay lang:html source/_layouts/post.html` %}
{% include revision.html %}{% endcoderay %}

这样，我们就可以在文章末尾看到本文的修改记录了。

