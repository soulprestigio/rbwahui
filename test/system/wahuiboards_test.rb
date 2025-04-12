require "application_system_test_case"

class WahuiboardsTest < ApplicationSystemTestCase
  setup do
    @wahuiboard = wahuiboards(:one)
  end

  test "visiting the index" do
    visit wahuiboards_url
    assert_selector "h1", text: "Wahuiboards"
  end

  test "should create wahuiboard" do
    visit wahuiboards_url
    click_on "New wahuiboard"

    fill_in "Description", with: @wahuiboard.description
    fill_in "Status", with: @wahuiboard.status
    fill_in "Title", with: @wahuiboard.title
    click_on "Create Wahuiboard"

    assert_text "Wahuiboard was successfully created"
    click_on "Back"
  end

  test "should update Wahuiboard" do
    visit wahuiboard_url(@wahuiboard)
    click_on "Edit this wahuiboard", match: :first

    fill_in "Description", with: @wahuiboard.description
    fill_in "Status", with: @wahuiboard.status
    fill_in "Title", with: @wahuiboard.title
    click_on "Update Wahuiboard"

    assert_text "Wahuiboard was successfully updated"
    click_on "Back"
  end

  test "should destroy Wahuiboard" do
    visit wahuiboard_url(@wahuiboard)
    click_on "Destroy this wahuiboard", match: :first

    assert_text "Wahuiboard was successfully destroyed"
  end
end
