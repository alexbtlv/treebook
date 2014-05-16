require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should have_many(:user_friendships)
	should have_many(:friends)
	should have_many(:activities)

	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:alex).profile_name
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new
		user.profile_name = "My profile name with spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end

	test "that no error is raised when trying to access a friend list" do
		assert_nothing_raised do
			users(:alex).friends
		end
	end

	test "that creating friendships on a user works" do
		users(:alex).pending_friends << users(:mike)
		users(:alex).pending_friends.reload
		assert users(:alex).pending_friends.include?(users(:mike))
	end

	test "that calling to_param on a user returns the profile name" do
		assert_equal 'alexander', users(:alex).to_param
	end

	context "#create activity" do
		should "increas the Activity count" do
			assert_difference 'Activity.count' do
				users(:alex).create_activity(statuses(:one), 'created')
			end
		end

		should "set the targetable instance to the item passed in" do
			activity = users(:alex).create_activity(statuses(:one), 'created')
			assert_equal statuses(:one), activity.targetable
		end

		should "increas the Activity count with an album" do
			assert_difference 'Activity.count' do
				users(:alex).create_activity(albums(:vacation), 'created')
			end
		end

		should "set the targetable instance to the item passed in with an album" do
			activity = users(:alex).create_activity(albums(:vacation), 'created')
			assert_equal albums(:vacation), activity.targetable
		end
	end

end
