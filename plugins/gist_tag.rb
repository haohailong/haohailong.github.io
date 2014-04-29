# A Liquid tag for Jekyll sites that allows embedding Gists and showing code for non-JavaScript enabled browsers and readers.
# Original code by: Brandon Tilly (http://brandontilley.com/2011/01/31/gist-tag-for-jekyll.html)
#
# Modifications by: Ryan Jennings (http://arg3.com.dev/blog/2012/03/07/better-octopress-gist-plugin/)
#  - removed cache tags in favor of parameters
#  - added GistTagApi tag to use the JSON api's
#  - GistTagApi renders markdown files directly (ex. README.md)
#
# Example usage: {% gistapi 12345 %} //embeds a gist for this plugin
#                {% gist 12345 nocache %}
#                {% gistapi 12345 cache code_file.rb %}

require 'cgi'
require 'digest/md5'
require 'net/https'
require 'uri'
require 'json'

module Jekyll

   class GistTag < Liquid::Tag

      def initialize(tag_name, text, token)
         super
         @cache_disabled = false
         @cache_folder   = File.expand_path "../.gist-cache", File.dirname(__FILE__)
         FileUtils.mkdir_p @cache_folder
         @text = text
      end

      def render(context)
         # ok parse the gist id and some options
         gist, options = get_options
         if !gist.empty?

            # check for a 'cache/nocache' parameter
            if options.length > 0
               @cache_disabled = options[0] == "nocache"
            end

            # check for a filename parameter
            file = options.length > 1 ? options[1] : String.new

            # check for cached data or download from api
            data = get_cached_gist(gist, file) || get_gist_from_web(gist, file)

            # render the gist
            render_gist gist, file, data
         end
      end

      # simply outputs the script tag
      def render_gist(gist, file, data)
         script_url = script_url_for gist, file
         html_output_for script_url, data
      end

      # cache's data for the gist
      def cache(gist, file, data)
         cache_file = get_cache_file_for gist, file
         File.open(cache_file, "w") do |io|
            io.write data
         end
      end

      # reads cached data for a gist
      def get_cached_gist(gist, file)
         return nil if @cache_disabled
         cache_file = get_cache_file_for gist, file
         File.read cache_file if File.exist? cache_file
      end

      # returns file name for cached gist data
      def get_cache_file_for(gist, file)
         bad_chars = /[^a-zA-Z0-9\-_.]/
         gist      = gist.gsub bad_chars, ''
         file      = file.gsub bad_chars, ''
         md5       = Digest::MD5.hexdigest "#{gist}-#{file}"
         File.join @cache_folder, "#{gist}-#{file}-#{md5}.cache"
      end

      # downloads gist data from the web
      def get_gist_from_web(gist, file)
         gist_url          = get_gist_url_for gist, file
         raw_uri           = URI.parse gist_url
         proxy             = ENV['http_proxy']
         if proxy
            proxy_uri       = URI.parse(proxy)
            https           = Net::HTTP::Proxy(proxy_uri.host, proxy_uri.port).new raw_uri.host, raw_uri.port
         else
            https           = Net::HTTP.new raw_uri.host, raw_uri.port
         end
         https.use_ssl     = true
         https.verify_mode = OpenSSL::SSL::VERIFY_NONE
         request           = Net::HTTP::Get.new raw_uri.request_uri
         data              = https.request request
         data              = data.body
         cache gist, file, data unless @cache_disabled
         data
      end

      # parses gist id and tag options
      def get_options
         if parts = @text.match(/([\d]*) (.*)/)
            return parts[1].strip, parts[2].split(",").map(&:strip)
         end
      end

      # simple outputs the script tag for the gist
      def html_output_for(script_url, code)
         code = CGI.escapeHTML code
         <<-HTML
         <div><script src='#{script_url}'></script>
         <noscript><pre><code>#{code}</code></pre></noscript></div>
         HTML
      end

      # the script url for the gist
      def script_url_for(gist_id, filename)
         "https://gist.github.com/#{gist_id}.js?file=#{filename}"
      end

      # the data url for the gist
      def get_gist_url_for(gist, file)
         "https://raw.github.com/gist/#{gist}/#{file}"
      end
   end

   # A class to get gists from the JSON api and provide output options for file types
   # Currently, Markdown files are handled
   class GistTagApi < GistTag

      def initialize(tag_name, text, token)
         super
      end

      # returns the url for the gists json api
      def get_gist_url_for(gist, file)
         "https://api.github.com/gists/#{gist}"
      end

      # renders the gist by parsing the json
      def render_gist(gist, file, data)
         json = JSON.parse(data)

         # get the list of gist files
         files = json["files"]

         # our output buffer
         output = ""

         files.each do |name,info|

            # if a file name was provided, only display that file
            if !file.empty? && file != name
               next
            end

            # raw gist content
            data = info["content"]

            # render markdown ourselves
            if info["language"] == "Markdown"
               output << data
               output << "\n\n"
            else
               script_url = script_url_for(gist, name)
               code = CGI.escapeHTML data
               output << "<div><script src='#{script_url}'></script>"
               output << "<noscript><pre><code>#{code}</code></pre></noscript></div>"
            end
         end
         CGI.unescapeHTML(output)
      end

   end
end

Liquid::Template.register_tag('gist', Jekyll::GistTag)
Liquid::Template.register_tag('gistapi', Jekyll::GistTagApi)
