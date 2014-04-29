# Title: Simple CodeRay Blocks
# Author: Hailong Hao (http://shengmingzhiqing.com/) based on the work of Jan Stevens (http://fritz-hut.com), Kat Hagan (http://codebykat.com), and Brandon Mathis
# Description: Modified version of Jan Steven and Brandon Mathis' code_block.rb that uses CodeRay for syntax highlighting. The Original Version by K. Hagan and B. Mathis has the Github style caption, but cannot add line nubmers, the 2nd Version by J. Steven has line number option, but with a new style. If you use J. Steven's version with original CSS/SASS, the capiton style cannot be displayed well. This plugin fixed that problem
#
# Syntax:
# {% coderay [lang:lang] [linenos:true|false(default)] [title] [url] [link text] %}
# code snippet
# {% endcoderay %}
#
# For syntax highlighting, put a file extension somewhere in the title or define lang. examples:
# {% coderay file.sh %}
# code snippet
# {% endcoderay %}
#
# {% coderay lang:ruby %}
# code snippet
# {% endcoderay %}
#
# {% coderay Time to be Awesome! (awesome.rb) %}
# code snippet
# {% endcoderay %}
#
# Example:
#
# {% coderay Got pain? painrelief.sh http://site.com/painrelief.sh Download it! %}
# $ rm -rf ~/PAIN
# {% endcoderay %}
#
# Output:
#
# <figure class='code'>
# <figcaption class='code-header'><span>Got pain? painrelief.sh</span> <a href="http://site.com/painrelief.sh">Download it!</a></figcaption>
# <div class="highlight"><pre><code class="sh">
# -- nicely escaped highlighted code --
# </code></pre></div>
# </figure>
#
# Example 2 (no syntax highlighting):
#
# {% coderay %}
# <sarcasm>Ooooh, sarcasm... How original!</sarcasm>
# {% endcoderay %}
#
# <figure class='code'>
# <pre><code>&lt;sarcasm> Ooooh, sarcasm... How original!&lt;/sarcasm></code></pre>
# </figure>
#

require './plugins/pygments_code'
require './plugins/raw'

module Jekyll

  class CodeRayBlock < Liquid::Block
    include HighlightCode
    include TemplateWrapper
    CaptionUrlTitle = /(\S[\S\s]*)\s+(https?:\/\/\S+|\/\S+)\s*(.+)?/i
    Caption = /(\S[\S\s]*)/

    def initialize(tag_name, markup, tokens)
      @title = nil
      @caption = nil
      @filetype = nil
      @highlight = true
      @linenos = false
      if markup =~ /\s*lang:(\S+)/i
        @filetype = $1
        markup = markup.sub(/\s*lang:(\S+)/i,'')
      end
      if markup =~/\s*linenos:(\S+)/i
        markup = markup.sub(/\s*linenos:(\S+)/i, '')
        @linenos = eval($1)
      end
      if markup =~ CaptionUrlTitle
        @file = $1
        @caption = "<figcaption class='code-header' style='margin-bottom:-5px;'><span>#{$1}</span><a href='#{$2}'>#{$3 || 'link'}</a></figcaption>"
      elsif markup =~ Caption
        @file = $1
        @caption = "<figcaption class='code-header' style='margin-bottom:-5px;'><span>#{$1}</span></figcaption>\n"
      end
      if @file =~ /\S[\S\s]*\w+\.(\w+)/ && @filetype.nil?
        @filetype = $1
      end
      super
    end

    def render(context)
      output = super
      code = super
      source = "<figure class='code'>"
      source += @caption if @caption
      coderay_css = context.registers[:site].config['kramdown']['coderay']['coderay_css'].to_sym
      line_numbers = @linenos ? context.registers[:site].config['kramdown']['coderay']['coderay_line_numbers'].to_sym : nil
      if @filetype
        source += " #{CodeRay.scan(code, @filetype).div(:css => coderay_css, :line_numbers => line_numbers, :tab_width=>4)} </figure>"
      else
        source += " #{CodeRay.scan(code, :text).div(:css => coderay_css, :line_numbers => line_numbers)} </figure>"
      end
      source = safe_wrap(source)
      source = context['pygments_prefix'] + source if context['pygments_prefix']
      source = source + context['pygments_suffix'] if context['pygments_suffix']
      source
    end
  end
end

Liquid::Template.register_tag('coderay', Jekyll::CodeRayBlock)
