require 'spec_helper'
require 'rack/test'
require 'rss'

require './lib/runner'

describe '/' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should response rss of Ticket Monster" do
    response = get('/')
    rss = RSS::Parser.parse(response.body)

    rss.channel.title.should == "티켓몬스터 일본 여행 RSS"
  end
end