# An octopress plugin for auto inserting spaces between Chinese and English characters
# By Zhiwei Xiao
#
# Install: place this file in OCTOPRESS_ROOT/plugins/

#encoding: UTF-8

require './plugins/post_filters'

module InsertSpaceFilter
  en = '[a-zA-Z0-9]'
  han = '\p{Han}'
  link = '[\[\(][^\]\)]*[\]\)]'
  del = '[\_\*]*'

  @@he_regex = /(#{han}#{del})(#{en})/  # 汉e 汉_/*e
  @@eh_regex = /(#{en})(#{del}#{han})/  # e汉 e_/*汉
  @@hne_regex = /(#{han})(\[#{en})/  # 汉[e
  @@enh_regex = /(#{en})(\[#{han})/  # e[汉
  @@hle_regex = /(\[.*?#{han}\]#{link})(#{en})/  # [...汉](...)e
  @@elh_regex = /(\[.*?#{en}\]#{link})(#{han})/  # [...e](...)汉

  def insert_ch_en_space(input)
    input.gsub(@@he_regex, '\1 \2').
      gsub(@@eh_regex, '\1 \2').
      gsub(@@hne_regex, '\1 \2').
      gsub(@@enh_regex, '\1 \2').
      gsub(@@hle_regex, '\1 \2').
      gsub(@@elh_regex, '\1 \2')
  end
end

module Jekyll           
  class MyFilters < PostFilter
    include InsertSpaceFilter
    def pre_render(post)
      post.content = insert_ch_en_space(post.content)
    end
  end
end

Liquid::Template.register_filter InsertSpaceFilter