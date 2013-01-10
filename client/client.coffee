Meteor.subscribe 'friends'

Template.hello.greeting = -> "Welcome to connected."

Template.hello.events 
  'click input' : -> console.log "You pressed the button"

Template.friends.friends = -> Friends.find()

