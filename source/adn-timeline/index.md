---
layout: page
title: "断章"
author: 郝海龙
comments: true
sharing: true
footer: true
---

本页是我一个人的微博，一个公开的树洞。<br />
如果你真的对我那么有兴趣，可以<a href='https://alpha.app.net/hailong' class='adn-button' target='_blank' data-type='follow' data-width='295' data-height='20' data-user-id='@hailong' data-show-username='1' rel='me'>在 APP.NET 关注我</a>。
{:.info}

<div>
  <ul id="adn_posts">
    <li class="loading">加载中……</li>
  </ul>
  <script type="text/javascript">
    $(document).ready(function(){
      getADNFeed("{{site.adn_user}}", {{site.adn_post_count}}, {{site.adn_show_replies}});
    });
  </script>
  <script src="{{ root_url }}/javascripts/adn.js" type="text/javascript"> </script>
</div>

{::nomarkdown}
<h4><a href="https://alpha.app.net/hailong" target="_blank">还想要更多？<i class="fa fa-arrow-circle-right"></i></a></h4>
{:/nomarkdown}