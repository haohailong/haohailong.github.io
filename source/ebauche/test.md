---
layout: page
title: "test"
author: 郝海龙
comments: true
sharing: true
footer: true
---

<section >
  <ul id="adn_posts">
    <li class="loading">加载中……</li>
  </ul>
  <script type="text/javascript">
    $(document).ready(function(){
      getADNFeed("{{site.adn_user}}", {{site.adn_post_count}}, {{site.adn_show_replies}});
    });
  </script>
  <script src="{{ root_url }}/javascripts/adn.js" type="text/javascript"> </script>
</section>