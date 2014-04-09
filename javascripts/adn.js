// JSON-P App.net fetcher for Octopress
// (c) Zachery Bir, based on Twitter fetcher by Brandon Mathis // MIT License

/* Sky Slavin, Ludopoli. MIT license.  * based on JavaScript Pretty Date * Copyright (c) 2008 John Resig (jquery.com) * Licensed under the MIT license.  */
function prettyDate(time) {
  if (navigator.appName === 'Microsoft Internet Explorer') {
    return "<span>&infin;</span>"; // because IE date parsing isn't fun.
  }
  var say = {
    just_now:    " now",
    minute_ago:  "1m",
    minutes_ago: "m",
    hour_ago:    "1h",
    hours_ago:   "h",
    yesterday:   "1d",
    days_ago:    "d",
    last_week:   "1w",
    weeks_ago:   "w"
  };

  var current_date = new Date(),
      current_date_time = current_date.getTime(),
      current_date_full = current_date_time + (1 * 60000),
      date = new Date(time),
      diff = ((current_date_full - date.getTime()) / 1000),
      day_diff = Math.floor(diff / 86400);

  if (isNaN(day_diff) || day_diff < 0) { return "<span>&infin;</span>"; }

  return day_diff === 0 && (
    diff < 60 && say.just_now ||
    diff < 120 && say.minute_ago ||
    diff < 3600 && Math.floor(diff / 60) + say.minutes_ago ||
    diff < 7200 && say.hour_ago ||
    diff < 86400 && Math.floor(diff / 3600) + say.hours_ago) ||
    day_diff === 1 && say.yesterday ||
    day_diff < 7 && day_diff + say.days_ago ||
    day_diff === 7 && say.last_week ||
    day_diff > 7 && Math.ceil(day_diff / 7) + say.weeks_ago;
}

function linkifyPost(text) {
  // Linkify urls, usernames
  text = text.replace(/(https?:\/\/)([\w\-:;?&=+.%#\/]+)/gi, '<a href="$1$2">$2</a>')
    .replace(/(^|\W)@(\w+)/g, '$1<a href="https://alpha.app.net/$2">@$2</a>')
    .replace(/\>\>/g, '&#x267B;');

  return text
}

function showADNFeed(posts, count, show_replies) {
  var timeline = document.getElementById('adn_posts'),
      content = '';

  var num = 0;
  for (var t in posts) {
      var post = posts[t];
      if (post.text &&
          num < count)
      {
          if (!show_replies && 
              (post.text[0] == '@' ||
               post.reply_to))
          {
              continue;
          }
          content += '<li>'+'<p>'+'<a class="author" href="' + post.user.canonical_url + '">@' + post.user.username + '</a> <a class="timestamp" href="'+post.canonical_url+'">'+prettyDate(post.created_at)+'</a> <div>'+linkifyPost(post.text.replace(/\n/g, '<br>'))+'</div></p>'+'</li>';
          num += 1;
      }
  }
  timeline.innerHTML = content;
}

function getADNFeed(user, count, show_replies) {
  count = parseInt(count, 10);
  $.ajax({
      url: "https://alpha-api.app.net/stream/0/users/@" + user + "/posts?count=" + (count + 20)
    , type: 'GET'
    , error: function (err) { $('#adn_posts li.loading').addClass('error').text("App.net’s unavailable"); }
    , success: function(data) { showADNFeed(data.data, count, show_replies); }
  })
}
