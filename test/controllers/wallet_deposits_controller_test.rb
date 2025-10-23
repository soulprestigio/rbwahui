require "test_helper"

class WalletDepositsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get wallet_deposits_new_url
    assert_response :success
  end

  test "should get create" do
    get wallet_deposits_create_url
    assert_response :success
  end
end
