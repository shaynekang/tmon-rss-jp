require 'rss/maker'


module TmonRss
  class Builder
    def build(crawler)
      feed = RSS::Maker.make("2.0") do |maker|
        maker.channel.title = "티켓몬스터 일본 여행 RSS"
        maker.channel.description = crawler.title
        maker.channel.link = crawler.url

        crawler.deals.each do |deal|
          title = "#{deal.title} - #{deal.price}원"
          link = deal.url
          description = <<-DESCRIPTION
            <![CDATA[
              <img src="#{deal.image}" alt="deal-thumbnail" />
              #{deal.description}
            ]]>
          DESCRIPTION
          description.gsub!(/\t|\n|\s{2}/, '')

          maker.items.new_item do |item|
            item.title = title
            item.link = link
            item.description = description
            item.updated = Time.now.to_s
          end
        end
      end.to_s

      feed.tap do |feed|
        feed.gsub!("&quot;", '"')
        feed.gsub!("&lt;", "<")
        feed.gsub!("&gt;", ">")
      end
    end
  end
end
