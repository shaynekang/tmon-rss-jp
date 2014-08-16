require 'spec_helper'
require 'rss'

require './lib/tmon_rss/app'


describe TmonRss::App do
  it "should crawl Tmon and return rss without deal" do
    url = "./spec/fixtures/no_deal.html"

    app = TmonRss::App.new
    result = app.run(url)
    rss = RSS::Parser.parse(result)

    rss.channel.title.should == "티켓몬스터 일본 여행 RSS"
    rss.channel.description.should == "티몬 :: 비교할수록 쇼핑은 티몬!"
    rss.channel.link.should == url
  end

  it "should crawl Tmon and return rss with one deal" do
    url = "./spec/fixtures/one_deal.html"

    app = TmonRss::App.new
    result = app.run(url)
    rss = RSS::Parser.parse(result)

    item = rss.items.first

    item.title.should == "[일본] 오키나와 3일 왕복항공권, 티웨이항공 - 99000원"
    item.link.should == "http://www.ticketmonster.co.kr/deal/47207337/101601/101629"
    item.description.should == "<img src=\"http://img1.tmon.kr/deals/4720/47207337/47207337_catlist_2col_v2_b3f41_1388712985production.jpg\" alt=\"deal-thumbnail\" />[유류+택스] 90,000원별도 / [성인 1인 기준]"

  end

  it "should crawl Tmon and return rss with two deals" do
    url = "./spec/fixtures/two_deal.html"

    app = TmonRss::App.new
    result = app.run(url)
    rss = RSS::Parser.parse(result)

    item = rss.items.last

    item.title.should == "[호텔] 호텔 오사카 베이타워, 초고층 객실 - 71000원"
    item.link.should == "http://www.ticketmonster.co.kr/deal/47290385/101601/101629"
    item.description.should == "<img src=\"http://img2.tmon.kr/deals/4729/47290385/47290385_catlist_2col_v2_1e1a7_1388737795production.jpg\" alt=\"deal-thumbnail\" />전 객실 30층 이상 /01.26 ~ 02.28"
  end
end
