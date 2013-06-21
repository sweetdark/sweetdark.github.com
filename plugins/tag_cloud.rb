require "stringex"
module Jekyll

  class TagCloud < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      @opts['bgcolor'] = '#ffffff'
      @opts['tcolor1'] = '#333333'
      @opts['tcolor2'] = '#333333'
      @opts['hicolor'] = '#000000'

      opt_names = ['bgcolor', 'tcolor1', 'tcolor2', 'hicolor']

      opt_names.each do |opt_name|
          if markup.strip =~ /\s*#{opt_name}:(#[0-9a-fA-F]+)/iu
            @opts[opt_name] = $1
            markup = markup.strip.sub(/#{opt_name}:\w+/iu,'')
          end
      end

      opt_names = opt_names[1..3]
      opt_names.each do |opt_name|
          @opts[opt_name] = '0x' + @opts[opt_name][1..8]
      end

      super
    end

    def render(context)
      lists = {}
      max, min = 1, 1
      config = context.registers[:site].config
      tag_dir = config['url'] + config['root'] + config['tag_dir'] + '/'
      tags = context.registers[:site].tags
      tags.keys.sort_by{ |str| str.downcase }.each do |tag|
        count = tags[tag].count
        lists[tag] = count
        max = count if count > max
      end

      bgcolor = @opts['bgcolor']

      bgcolor = @opts['bgcolor']
      tcolor1 = @opts['tcolor1']
      tcolor2 = @opts['tcolor2']
      hicolor = @opts['hicolor']

      html = ''
      html << "<embed type='application/x-shockwave-flash' src='/javascripts/tagcloud.swf'"
      html << "width='100%' height='250' bgcolor='#{bgcolor}' id='tagcloudflash' name='tagcloudflash' quality='high' allowscriptaccess='always'"

      html << 'flashvars="'
      html << "tcolor=#{tcolor1}&amp;tcolor2=#{tcolor2}&amp;hicolor=#{hicolor}&amp;tspeed=100&amp;distr=true&amp;mode=tags&amp;"

      html << 'tagcloud='

      tagcloud = ''
      tagcloud << '<tags>'


      lists.each do | tag, counter |
        #url = tag_dir + tag.gsub(/_|\P{Word}/u, '-').gsub(/-{2,}/u, '-').downcase
		url = tag_dir + tag.to_url.downcase
        style = "font-size: #{10 + (40 * Float(counter)/max)}%"

        tagcloud << "<a href='#{url}' style='#{style}'>#{tag}"
        tagcloud << "</a> "

      end

      tagcloud << '</tags>'

      # tagcloud urlencode
      tagcloud = CGI.escape(tagcloud)

      html << tagcloud
      html << '">'
      html
    end
  end
end

Liquid::Template.register_tag('tag_cloud', Jekyll::TagCloud)