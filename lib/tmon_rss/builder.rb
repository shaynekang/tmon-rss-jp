require 'rss/maker'


module TmonRss
  class Builder
    def build(crawler)
      RSS::Maker.make("2.0") do |maker|
        maker.channel.title = "티켓몬스터 일본 여행 RSS"
        maker.channel.description = crawler.title
        maker.channel.link = crawler.url

        crawler.deals.each do |deal|
          maker.items.new_item do |item|
            item.title = "#{deal.title} - #{deal.price}원"
            item.link = deal.url
            item.description = deal.description
          end
        end
      end.to_s
    end
  end
end