Meteor.publish 'friends', -> 
  Friends.find user: @userId, 
    limit: 15
    sort: "name"

Meteor.startup -> 
 console.log "put server code here"