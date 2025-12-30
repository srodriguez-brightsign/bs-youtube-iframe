function main()

    mp = CreateObject("roMessagePort")

    ' bundle.js launches a NodeJS Express Server instance on port 9090 to host the youtube.html file
    node = CreateObject("roNodeJs", "YouTube/bundle.js", {message_port:mp})

    sleep(5000) ' Pause for 5 seconds to allow Express server to launch
    
    r = CreateObject("roRectangle",0,0,1920,1080)
    config = {
		hwz_default: "on"
		mouse_enabled: true
		nodejs_enabled: true
		brightsign_js_objects_enabled: true
		inspector_server: {
			port: 3000
		}

        ' Player should load a HTML widget pointing to itself using port 9090
        ' videoId is the ID of the YouTube video from the YouTube URL https://youtube.com/watch?v=VIDEOID, this parameter is required
        ' Other parameters supported are 'playlist', 'autoplay', 'mute', 'rel', 'controls', 'showinfo', and 'loop'
        ' Modify the youtube.html file to change your desired defaults or add support for additional URL parameters
		url: "http://localhost:9090/youtube.html?videoId=yRuNROeVVKg&autoplay=1&loop=1"
		port: mp
	}

  ' Create HTML Widget
	h = CreateObject("roHtmlWidget",r,config)
  h.Show()

  while true
    ' Loop forever to stop the script from stopping
  end while

end function