Template.todo_tag.events = {
  'click .remove': (evt) ->
    tag = this.tag
    id  = this.todo_id

    evt.target.parentNode.style.opacity = 0
    # wait for CSS animation to finish
    Meteor.setTimeout(->
      Friends.update {_id: id}, {$pull: {tags: tag}}
    , 300)
  }

# Pick out the unique tags from all todos in current list.
Template.tag_filter.tags = ->
  tag_counts  = {}
  total_count = 0

  for friend in Friends.find().fetch()
    for tag in friend.tags || []
      tag_counts[tag] = 0 unless tag_counts[tag]?
      tag_counts[tag]++
    total_count++

  tag_infos = for tag, count of tag_counts
    { tag: tag, count: count }

  tag_infos = _.sortBy tag_infos, (x) -> x.tag
  tag_infos.unshift { tag: null, count: total_count }

  return tag_infos

Template.tag_item.tag_text = -> this.tag or "All items"

Template.tag_item.selected = -> if Session.equals('tag_filter', this.tag) then 'selected' else ''

Template.tag_item.events = {
  'mousedown': ->
    if Session.equals 'tag_filter', this.tag
      Session.set 'tag_filter', null
    else
      Session.set 'tag_filter', this.tag
  }

$ ->
  add_inline_editing_events Template.friend, "#edittag-input", {
    ok: (value) ->
      Friends.update this._id, {$addToSet: {tags: value}}
      Session.set "editing_addtag", null
    cancel: ->
      Session.set "editing_addtag", null
  }