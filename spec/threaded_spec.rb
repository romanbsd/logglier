require 'spec_helper'

describe Logglier::Client::HTTP::DeliveryThread do
  before do
    @mock_http = MockNetHTTPProxy.new
    Logglier::Client::HTTP::NetHTTPProxy.stub(:new) { @mock_http }
  end

  subject { described_class.new(URI.parse('http://localhost')) }

  before do
    subject.stub(:deliver)
  end

  it "should" do
    @mock_http.should_receive(:deliver).with("test")
    subject.push('test')

    #Signal the thread it's going to exit
    subject.exit!

    #Wait for it to exit
    subject.join
  end
end
