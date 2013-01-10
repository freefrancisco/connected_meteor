Meteor.subscribe 'friends'

Template.friendsList.friends = -> Friends.find()

