Meteor.publish 'friends', -> Friends.find()

Meteor.startup -> 
 console.log "put server code here"