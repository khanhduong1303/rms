require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should save event" do
    assert_difference('Event.count') do
      post :save, event: { date: @event.date, description: @event.description, event_end: @event.event_end, event_start: @event.event_start, location: @event.location, name: @event.name, organiser: @event.organiser }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { date: @event.date, description: @event.description, event_end: @event.event_end, event_start: @event.event_start, location: @event.location, name: @event.name, organiser: @event.organiser }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
