require "#{File.dirname(__FILE__)}/test_helper"

class AssetAutoIncludeTest < ActionView::TestCase
  attr_reader :controller

  context "A controller that has a set of related JS and CSS files" do
    
    setup do
      @controller = mock("mock controller")
      @controller.expects(:controller_path).returns("foo/bar").at_least_once
      @controller.expects(:action_name).returns("new").at_least_once
    end

    context "auto-loading Javascript" do
      setup { fake_response javascript_auto_include_tags }
      
      should "include any files for the entire controller" do
        assert_select 'script[src$=foo/bar/controller.js]'
      end
    
      should "include any files only for the current action" do
        assert_select 'script[src$=foo/bar/new.js]'
      end
  
      should "include any files also available for the current action" do
        assert_select 'script[src$=foo/bar/new-edit.js]'
      end
  
      should "not include any files for other actions" do
        assert_select 'script[src$=foo/bar/edit.js]', :count => 0
      end
      
    end # auto-loading Javascript
    
    context "auto-loading stylesheets" do
      setup { fake_response stylesheet_auto_include_tags }
      
      should "include any files for the entire controller" do
        assert_select 'link[href$=foo/bar/controller.css]'
      end
    
      should "include any files only for the current action" do
        assert_select 'link[href$=foo/bar/new.css]'
      end
  
      should "include any files also available for the current action" do
        assert_select 'link[href$=foo/bar/new-index.css]'
      end

      should "include print files also available for the current action" do
        assert_select 'link[href$=foo/bar/new.print.css][media="print"]'
      end
  
      should "not include print files as non-print media" do
        assert_select 'link[href$=foo/bar/new.print.css][media="screen"]', :count => 0
      end

      should "not include any files for other actions" do
        assert_select 'link[href$=foo/bar/index.css]', :count => 0
      end
      
    end # auto-loading stylesheets
    
  end # A controller that has a set of related JS files
  
  context "A controller that has no JS or CSS files" do

    setup do
      @controller = mock("mock controller")
      @controller.expects(:controller_path).returns("baz").at_least_once
      @controller.expects(:action_name).returns("new").at_least_once
    end

    should "not include any javascript files" do
      fake_response javascript_auto_include_tags
      assert @response.body.blank?
    end

    should "not include any stylesheet files" do
      fake_response stylesheet_auto_include_tags
      assert @response.body.blank?
    end

  end # A controller that has no JS or CSS files
  
end


