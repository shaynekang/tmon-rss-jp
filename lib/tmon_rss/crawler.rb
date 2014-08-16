require 'nokogiri'
require 'open-uri'

module TmonRss
  class Crawler
    def initialize(url)
      @url = url
      @doc = Nokogiri::HTML(open(@url))
    end

    def title
      @doc.at_css('title').content.strip
    end

    def url
      @url
    end

    def deals
      @doc.css('li.dealli').map do |deal|
        subject = deal.at_css('a.subject')

        title = subject.content
        url = subject['href']

        price = deal.at_css('p.sale em').content
        price = price.split(',').join.to_i

        image = deal.at_css('a.thmb img')
        image = image['src']

        description = deal.at_css('p.summary').content
        description.strip!

        OpenStruct.new({
          title: title,
          price: price,
          image: image,
          description: description,
          url: "http://www.ticketmonster.co.kr" + url
        })
      end
    end
  end
end
