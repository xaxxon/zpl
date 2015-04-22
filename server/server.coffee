Meteor.startup ->
	if playlist_collection.find().count() == 0 and 
		song_collection.find().count() == 0 and
		playlist_order_collection.find().count() == 0
			pid1 = playlist_collection.insert
				name: "default_playlist 1"
			pid2 = playlist_collection.insert
				name: "default_playlist 2"
				
			sid1 = song_collection.insert
				name: "default song 1"
			sid2 = song_collection.insert
				name: "default song 2"
			sid3 = song_collection.insert
				name: "default song 3"
				
			playlist_order_collection.insert
				 playlist_id: pid1
				 song_id: sid1
				 position: 1
			playlist_order_collection.insert
				 playlist_id: pid1
				 song_id: sid2
				 position: 2
			playlist_order_collection.insert
				 playlist_id: pid1
				 song_id: sid3
				 position: 3
			playlist_order_collection.insert
				 playlist_id: pid2
				 song_id: sid2
				 position: 1
			playlist_order_collection.insert
				 playlist_id: pid2
				 song_id: sid1
				 position: 2
			
		