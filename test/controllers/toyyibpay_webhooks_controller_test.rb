require "test_helper"

class ToyyibpayWebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get toyyibpay_webhooks_create_url
    assert_response :success
  end
end
