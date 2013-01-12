Friends = new Meteor.Collection 'friends'

Friends.refreshIds = (userId) -> 
  user = Meteor.users.findOne _id: userId
  if user?.services?.facebook?
    result = Meteor.http.call "GET", "https://graph.facebook.com/#{user.services.facebook.id}/friends", 
      params: 
        access_token: user.services.facebook.accessToken 
        # limit: 20 
    if result?.data?.data?    
      friends = result.data.data
      for friend in friends
        unless Friends.findOne { user: userId, facebook_id: friend.id }
          Friends.insert user: userId, facebook_id: friend.id, name: friend.name, tags: []

Meteor.methods
  refreshIds: -> 
    @unblock()
    Friends.refreshIds(@userId)
    