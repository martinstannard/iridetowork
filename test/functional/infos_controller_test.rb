require File.dirname(__FILE__) + '/../test_helper'
require 'infos_controller'

# Re-raise errors caught by the controller.
class InfosController; def rescue_action(e) raise e end; end

class InfosControllerTest < Test::Unit::TestCase
  fixtures :infos

  def setup
    @controller = InfosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = infos(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:infos)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:info)
    assert assigns(:info).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:info)
  end

  def test_create
    num_infos = Info.count

    post :create, :info => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_infos + 1, Info.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:info)
    assert assigns(:info).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Info.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Info.find(@first_id)
    }
  end
end
