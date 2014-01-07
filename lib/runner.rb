require 'sinatra'
require './lib/tmon_rss/app'

get '/' do
  url = "http://www.ticketmonster.co.kr/deallist/101601/101629"

  app = TmonRss::App.new
  app.run(url)
end