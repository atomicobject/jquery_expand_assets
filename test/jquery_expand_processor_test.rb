require 'test/unit'
require 'ostruct'
require 'jquery_expand_assets/jquery_expand_processor'

class JqueryExpandProcessorTest < Test::Unit::TestCase
  def test_wraps_content_with_expand_function
    content = "<p><div>butters cookies</div></p>"
    processor = build_with_content(content)

    result = processor.evaluate(scope, nil)

    assert_match content, result
    assert_match %r{template.expand\(directive\).children\(\)}, result
  end

  def test_the_default_namespace
    processor = build

    assert_equal 'this.JST', processor.namespace
  end

  def test_uses_name_filter_to_setup_template_name
    processor = build

    result = processor.evaluate(scope('templates/projects/_comment'), nil)

    assert_match 'this.JST["projects/comment"]', result
  end

  private
  def build_with_content(content='')
    JqueryExpandAssets::JqueryExpandProcessor.new do content end
  end
  alias_method :build, :build_with_content

  def scope(logical_path = ''); os(logical_path: logical_path); end
  def os(*args); OpenStruct.new(*args); end
end
