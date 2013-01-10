Meteor.subscribe 'friends'

Template.friendsList.friends = -> 
  select_criteria = {}
  tag_filter = Session.get 'tag_filter'
  select_criteria.tags = tag_filter if tag_filter
  Friends.find select_criteria
  
Template.friend.adding_tag = -> Session.equals 'editing_addtag', this._id
Template.friend.tag_objs = ->
  friend_id = this._id
  return _.map(this.tags or [], (tag) -> {friend_id: friend_id, tag: tag})

Template.friend.events = {
  'click .addtag': (evt) ->
    Session.set 'editing_addtag', this._id
    Meteor.flush() # update DOM before focus
    $("#edittag-input").focus()
  'dblclick .display .friend-text': (evt) ->
    Session.set 'editing_itemname', this._id
    Meteor.flush() # update DOM before focus
    $("#friend-input").focus()
}

Meteor.startup ->
  Meteor.call("refreshIds") if userId

