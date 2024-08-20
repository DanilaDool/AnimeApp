require "test_helper"

class BottomPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get agreement" do
    get bottom_pages_agreement_url
    assert_response :success
  end

  test "should get confidentiality" do
    get bottom_pages_confidentiality_url
    assert_response :success
  end

  test "should get aboutus" do
    get bottom_pages_aboutus_url
    assert_response :success
  end
end
