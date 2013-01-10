if Meteor.isClient
  Template.hello.greeting = -> "Welcome to connected."

  Template.hello.events 
    'click input' : -> console.log "You pressed the button"
  


if Meteor.isServer
  Meteor.startup -> 
   console.log "put server code here"