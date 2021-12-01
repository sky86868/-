require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(title: "test-title", text: "test-text")
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "title should not be empty" do
    @article.title = ""
    assert_not @article.valid?
  end

  test "title should be too short" do
    @article.title = "tes"
    assert_not @article.valid?
  end

end
