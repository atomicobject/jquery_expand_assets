require 'minitest/autorun'
require 'ostruct'
require 'jquery_expand_assets/jquery_expand_processor'

class JqueryExpandProcessorTest < MiniTest::Unit::TestCase
  def test_wraps_content_with_expand_function
    result = process content: "<p><div>butters cookies</div></p>"

    assert_match "<p><div>butters cookies</div></p>", result
    assert_match %r{\.expand\(directive\)\.children\(\)}, result
  end

  def test_names_the_template_after_the_file_name
    result = process filename: 'templates/projects/_comment'

    assert_match 'this.JST["projects/comment"]', result
  end

  def test_handles_file_names_with_multiple_levels_of_nesting
    result = process filename: 'templates/projects/comments/concerns/_alert'

    assert_match 'this.JST["projects/comments/concerns/alert"]', result
  end

  def test_does_not_yet_handle_file_names_with_one_level_of_nesting
    result = process filename: 'templates/_comment'

    refute_match 'this.JST["comment"]', result
  end

  def test_handles_template_names_without_leading_underscore
    result = process filename: 'templates/users/avatar'

    assert_match 'this.JST["users/avatar"]', result
  end

  def test_handles_template_names_with_embedded_underscores
    result = process filename: 'templates/users/foo_bar_baz_qux_quux'

    assert_match 'this.JST["users/foo_bar_baz_qux_quux"]', result
  end

  def test_handles_directory_names_with_embedded_underscores
    result = process filename: 'templates/admin_users/foo_bar_baz_qux_quux'

    assert_match 'this.JST["admin_users/foo_bar_baz_qux_quux"]', result
  end

  def test_handles_deep_directory_trees_with_embedded_underscores
    result = process filename: 'templates/stuff_1/admin_users/foo_bar_baz_qux_quux'

    assert_match 'this.JST["stuff_1/admin_users/foo_bar_baz_qux_quux"]', result
  end

  private
  def process(optz)
    content, filename = optz.values_at(:content, :filename)
    content ||= "<b>grover</b>"
    filename ||= "butters/_cookies"

    processor = JqueryExpandAssets::JqueryExpandProcessor.new do content end
    processor.evaluate(os(logical_path: filename), nil)
  end

  def build_with_content(content='')
    JqueryExpandAssets::JqueryExpandProcessor.new do content end
  end
  alias_method :build, :build_with_content

  def scope(logical_path = ''); os(logical_path: logical_path); end
  def os(*args); OpenStruct.new(*args); end
end
