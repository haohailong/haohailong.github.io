module Jekyll
  class CategoryListTag < Liquid::Tag
    def render(context)
      html = ""
      categories = context.registers[:site].categories.keys
      categories.sort.each do |category|
        posts_in_category = context.registers[:site].categories[category].size
        html << "<li class='category'><a href='/blog/categories/#{category.downcase}/'>#{category} (#{posts_in_category})</a></li>\n"
      end
      html
    end
  end
end

Liquid::Template.register_tag('category_sidebar', Jekyll::CategoryListTag)