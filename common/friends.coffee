Friends = new Meteor.Collection 'friends'

Friends.loadFromFacebook = (userId) -> 
  console.log "called fetch friends, user id: #{userId}"
  user = Meteor.users.findOne
    _id: userId
  # console.log user
  fbid = user?.services?.facebook?.id
  token = user?.services?.facebook?.accessToken
  console.log "fb id: #{fbid}, token: #{token}"
  result = Meteor.http.call "GET", "https://graph.facebook.com/#{fbid}/friends",
    params:
      access_token: token
      # fields: "id"
      
  friends = result.data.data
  for friend in friends
    found = Friends.findOne {facebook_id: friend.id}
    console.log found
    # console.log "found friend: #{found}"
    # console.log JSON.stringify(found)
    if found?
      Friends.update {facebook_id: friend.id}, {user: userId, facebook_id: friend.id, name: friend.name} 
      console.log "found friend #{friend} in Friends already"
    else
      Friends.insert {user: userId, facebook_id: friend.id, name: friend.name} 
      console.log "inserted friend #{friend} into Friends"    
  "foo #{userId}"


Meteor.methods
  fetchFriends: ->
    Friends.loadFromFacebook(@userId)
    # console.log "called fetch friends, user id: #{@userId}"
    # user = Meteor.users.findOne
    #   _id: @userId
    # # console.log user
    # fbid = user?.services?.facebook?.id
    # token = user?.services?.facebook?.accessToken
    # console.log "fb id: #{fbid}, token: #{token}"
    # result = Meteor.http.call "GET", "https://graph.facebook.com/#{fbid}/friends",
    #   params:
    #     access_token: token
    #     # fields: "id"
    #     
    # friends = result.data.data
    # Friends.insert friend for friend in friends unless Friends.find {id: friend?.id}
    # 
    # console.log result.data.data
    # user.friends = result.data.data


    # Meteor.users.update
    #   _id: @userId
    # ,
    #   fields:
    #     services: 1
    #     resume: 1
    #     friends: 1
    # 
    # return JSON.stringify result.data.data if result.statusCode is 200
    # return "baaaaaugh"
    # 
    # console.log (j for j of result)
    # console.log(result)
    # return true  if result.statusCode is 200
    # false
    