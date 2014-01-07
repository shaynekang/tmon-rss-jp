require 'spec_helper'
require './lib/tmon_rss/crawler'


describe TmonRss::Crawler do
  it "should crawl Ticket Monster without deal" do
    url = "./spec/fixtures/no_deal.html"

    crawler = TmonRss::Crawler.new(url)

    crawler.title.should == "티몬 :: 비교할수록 쇼핑은 티몬!"
    crawler.url.should == url
  end

  it "should crawl Ticket Monster with one deal" do
    url = "./spec/fixtures/one_deal.html"

    crawler = TmonRss::Crawler.new(url)

    deal = crawler.deals.first

    deal.title.should == "[일본] 오키나와 3일 왕복항공권, 티웨이항공"
    deal.price.should == 99000
    deal.url.should == "http://www.ticketmonster.co.kr/deal/47207337/101601/101629"
    deal.description.should == "[유류+택스] 90,000원별도 / [성인 1인 기준]"
  end

  it "should crawl Ticket Monster with two deals" do
    url = "./spec/fixtures/two_deal.html"

    crawler = TmonRss::Crawler.new(url)
    deal = crawler.deals.last

    deal.title.should == "[호텔] 호텔 오사카 베이타워, 초고층 객실"
    deal.price.should == 71000
    deal.url.should == "http://www.ticketmonster.co.kr/deal/47290385/101601/101629"
    deal.description.should == "전 객실 30층 이상 /01.26 ~ 02.28"
  end
end