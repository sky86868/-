require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "create article" do
    assert_difference 'Article.count' do
      post articles_path, params: {
        article: {
          title: "test-title-1",
          text: "test-text-1"
        }
      }
    end
  end

end
