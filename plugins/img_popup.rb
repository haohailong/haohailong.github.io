# This plugin uses Mini Magick to generate a scaled down, inline image (really,
# it just uses Mini Magick to calculate the appropriate size; the real image is
# scaled by the browser), and then generates a popup with the full-size image,
# using jQuery UI Dialog. The printer-friendly view just uses the full-size
# image.
#
# >>>>>
# Modified the plugin to actually use Mini Magick to scaled down the image, and save it
# at source folder. It's a bit tricky, you may want to check the code.
# <<<<<
#
# This plugin is useful when you have to display an image that's too wide for
# the blog.
#
# USAGE:
#
#     imgpop /relative/path/to/image nn% class title
#
#     The image path is relative to "source". The second parameter is the scale
#     percentage. The third parameter html class for the popup, and
#     the last is a title for the popup.
#
# CSS:
#
# To control what's shown on the screen versus what's shown when the article
# is printed, this plugin generates HTML with two classes: "screen" and "print".
# If your CSS rules use those classes appropriately, you can hide the printable
# view on the browser and vice versa.
#
# >>>>>
# Modified the plugin to just generate one img tag per image. The full size image is
# loaded when the image clicked at the first time. ;)
# <<<<<
#
# PREREQUISITES:
#
# To use this plugin, you'll need:
#
# - the mini_magick gem (in the Gemfile)
# - the Image Magick tool kit's mogrify(1) command installed on your system
#   and in the PATH
# - jQuery (in source/javascripts and in your head.html)
# - jQuery UI (in source/javascripts and in your head.html)
# - Place your jQuery UI css file before screen.css
#
# EXAMPLE:
#
#     {% imgpop /images/my-big-image.png 50% center Check this out %}
#
#     You can see this plugin in use here:
#
#     [original]
#     http://brizzled.clapper.org/blog/2011/10/23/the-candidates/
#
#     [My modified version]
#     http://fudanchii.net/
#
# Copyright (c) 2012 Brian M. Clapper <bmc@clapper.org>
#               2012 Nurahmadie       <nurahmadie@gmail.com>
#
# Released under a standard BSD license.

require 'mini_magick'
require 'rubygems'
require 'erubis'
require './plugins/raw'

module Jekyll

  class ImgPopup < Liquid::Tag
    include TemplateWrapper

    @@id = 0

    TEMPLATE_NAME = 'img_popup.html.erb'

    def initialize(tag_name, markup, tokens)
      args = markup.strip.split(/\s+/, 4)

      # Unlike the original, I made all 4 parameters mandatory.
      raise "Usage: imgpop path nn% class title" unless [4].include? args.length

      @path = args[0]
      if args[1] =~ /^(\d+)%$/
        @percent = $1
      else
        raise "Percent #{args[1]} is not of the form 'nn%'"
      end

      template_file = Pathname.new(__FILE__).dirname + TEMPLATE_NAME
      @template = Erubis::Eruby.new(File.open(template_file).read)

      @class = args[2]
      @title = args[3]
      super
    end

    def render(context)
      source = Pathname.new(context.registers[:site].source).expand_path
      
      # Calculate the full path to the source image.
      image_path = source + @path.sub(%r{^/}, '')
  
      # Our scaled image path name
      resized_image = "#{File.dirname(@path.sub(%r{^/}, ''))}/resized_#{File.basename(@path)}"
      if @percent == "100"
        resized_mage = @path.sub(%r{^/}, '')
      end

      @@id += 1
      vars = {
        'id'      => @@id.to_s,
        'image'   => @path,
        'title'   => @title,
        'klass'   => @class
      } 

      # Open the source image, and scale it accordingly.
      image = MiniMagick::Image.open(image_path)
      vars['full_width'] = image[:width]
      vars['full_height'] = image[:height]
      image.resize "#{@percent}%"

      rpath = source+ resized_image
      if not File.exists?(rpath) and @percent.to_i < 100
      # Actually save the image
        if image[:format] == "jpg"
          image.quality "95"
        end
        image.write rpath

        # This is the tricky part
        # we should registers the new created file
        # since Jekyll already indexed all files before
        context.registers[:site].static_files << StaticFile.new(
          context.registers[:site], source, File.dirname(@path.sub(%r{^/}, '')),
          "resized_#{File.basename(@path)}")
        print "image saved to #{rpath}\n"
      end

      vars['scaled_width'] = image[:width]
      vars['scaled_height'] = image[:height]
      vars['scaled_image'] = "/#{resized_image}"

      safe_wrap(@template.result(vars))
    end
  end
end

Liquid::Template.register_tag('imgpop', Jekyll::ImgPopup)