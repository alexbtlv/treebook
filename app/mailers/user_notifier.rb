class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

	def friend_requested(user_friendship_id)
	  	user_friendship = UserFriendship.find(user_friendship_id)

	  	@user = user_friendship.user
	  	@friend = user_friendship.friend

	  	mail to: @friend.email,
	  		sbject: "#{@user.first_name} wants to be friends on Treebook"
	end

	def friend_request_accepted(user_friendship_id)
	  	user_friendship = UserFriendship.find(user_friendship_id)

	  	@user = user_friendship.user
	  	@friend = user_friendship.friend

	  	mail to: @friend.email,
	  		sbject: "#{@user.first_name} accepted your friend request on Treebook"
  	end   
end
