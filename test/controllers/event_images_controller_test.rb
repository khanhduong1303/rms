require 'test_helper'

class EventImagesControllerTest < ActionController::TestCase
  setup do
    @event_image = event_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should save event_image" do
    assert_difference('EventImage.count') do
      post :save, event_image: { description: @event_image.description }
    end

    assert_redirected_to event_image_path(assigns(:event_image))
  end

  test "should show event_image" do
    get :show, id: @event_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_image
    assert_response :success
  end

  test "should update event_image" do
    patch :update, id: @event_image, event_image: { description: @event_image.description }
    assert_redirected_to event_image_path(assigns(:event_image))
  end

  test "should destroy event_image" do
    assert_difference('EventImage.count', -1) do
      delete :destroy, id: @event_image
    end

    assert_redirected_to event_images_path
  end
end
