require "test_helper"

class WahuiboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wahuiboard = wahuiboards(:one)
  end

  test "should get index" do
    get wahuiboards_url
    assert_response :success
  end

  test "should get new" do
    get new_wahuiboard_url
    assert_response :success
  end

  test "should create wahuiboard" do
    assert_difference("Wahuiboard.count") do
      post wahuiboards_url, params: { wahuiboard: { description: @wahuiboard.description, status: @wahuiboard.status, title: @wahuiboard.title } }
    end

    assert_redirected_to wahuiboard_url(Wahuiboard.last)
  end

  test "should show wahuiboard" do
    get wahuiboard_url(@wahuiboard)
    assert_response :success
  end

  test "should get edit" do
    get edit_wahuiboard_url(@wahuiboard)
    assert_response :success
  end

  test "should update wahuiboard" do
    patch wahuiboard_url(@wahuiboard), params: { wahuiboard: { description: @wahuiboard.description, status: @wahuiboard.status, title: @wahuiboard.title } }
    assert_redirected_to wahuiboard_url(@wahuiboard)
  end

  test "should destroy wahuiboard" do
    assert_difference("Wahuiboard.count", -1) do
      delete wahuiboard_url(@wahuiboard)
    end

    assert_redirected_to wahuiboards_url
  end
end
