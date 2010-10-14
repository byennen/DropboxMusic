require 'rubygems'
require 'shoulda'
require 'mocha'
require 'ostruct'
require 'test/unit'
require 'action_controller'
require 'action_view/test_case'
require 'action_controller/test_process'
RAILS_ROOT = "#{File.dirname(__FILE__)}/faux_rails"
$: << "#{File.dirname(__FILE__)}/../lib"
require "#{File.dirname(__FILE__)}/../init"

class Test::Unit::TestCase
  def fake_response(body, opts = {})
    @response ||= OpenStruct.new(:body => body, :content_type => opts[:content_type] || "application/xml")
  end
end