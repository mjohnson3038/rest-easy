require 'test_helper'

class ReceiptsControllerTest < ActionController::TestCase
  test "whether the tests are running" do
    assert true
  end

  # receipt#new
  test "should get a form to upload a receipt" do
    get :new
    assert_response :success
    assert_template :new

  end

  # receipt#create
  test "whether the page redirects when a new receipt image is uploaded" do
    post_params = { receipt: {name: "tester"}, attachment: "IMG_4503.JPG"}
    assert_difference('Receipt.count', 1) do
      post :create, post_params
    end
    assert_redirected_to receipts_path
  end

  test "flash message when file is not of image type" do
    post_params = { receipt: {name: "tester"}, attachment: "IMG_4503.PDF"}
    post :create, post_params
    assert_response :error
  end

  # receipt#show
  test "should get show" do
    # recall how to select the yml and take the id from that yml
    get :show, {id: receipts(:three).id}
    assert_response :success
    assert_template :show

    assert_equal assigns(:receipt), receipts(:three)
  end
end
