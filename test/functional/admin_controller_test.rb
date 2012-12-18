require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get inipage" do
    get :inipage
    assert_response :success
  end

end
