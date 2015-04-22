Template.Master.helpers
	template_name: -> Session.get("current_page")

	
Meteor.startup ->
	Session.set("current_page", "Playlists")


Template.Master.events
	'click #songs_page': -> Session.set "current_page", "Songs"
	'click #playlists_page': -> Session.set "current_page", "Playlists"


Template.Playlists.helpers
	playlists: -> 
		console.log playlist_collection.find().count()
		playlist_collection.find()
	
	
Template.Playlists.events
	'click .playlist': (event)->
		console.log this
	'click .delete': ->
		alert "not implemented"
	'click .edit': ->
		console.log this._id
		console.log "playlist id #{this._id}"
		Session.set "current_playlist_id", this._id
		Session.set "current_page", "CustomizePlaylist"
	
		
Template.CustomizePlaylist.rendered = ->
	this.$('#song_order').sortable
		stop: (e, ui) ->
			song = ui.item
			song_data = Blaze.getData(song.get(0))
			song_before_position = Blaze.getData(song.prev().get(0))?.position if song.prev().length
			song_after_position = Blaze.getData(song.next().get(0))?.position if song.next().length
			song_before_position ?= song_after_position? - 2
			song_after_position ?= song_before_position? + 2
			console.log "#{song_before_position} #{song_after_position}}"
			if song_before_position
				playlist_order_collection.update song_data._id, {$set: {position: (song_before_position + song_after_position) / 2}},{},(error, thing)->console.log "update results: "; console.log error; console.log thing
	
Template.Songs.helpers
	songs: -> song_collection.find()
	
	
Template.CustomizePlaylist.helpers
		
	playlist: -> playlist_collection.findOne(Session.get("current_playlist_id"))
	playlist_elements: -> 
		order = playlist_order_collection.find({playlist_id: Session.get "current_playlist_id"},{sort:{position: 1}}).fetch()
		songs = song_collection.find().fetch()
		songs = songs.reduce(
			(previous, current)->
				previous[current._id] = current
				previous
			{})
		thing.song = songs[thing.song_id] for thing in order
		
		order
	
