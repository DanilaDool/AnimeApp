require "test_helper"

class SearchResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get search_results_show_url
    assert_response :success
  end
end
