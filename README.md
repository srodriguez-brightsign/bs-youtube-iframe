# New YouTube iFrame Integration
YouTube now requires the `HTTP Referer` request header to be included when embedding videos. When this request header is not specified, end users are presented with Error 153. The YouTube documentation provides more information on this here: https://developers.google.com/youtube/terms/required-minimum-functionality#embedded-player-api-client-identity

We cover three scenarios in this documentation, please click the one that fits you best to skip ahead to the appropriate section:
1. [I am a BA:Connected/BSN.Content user, but I do not have an option to host a web server.](#i-am-a-baconnectedbsncontent-user-but-i-do-not-have-an-option-to-host-a-web-server)
2. [I am a BA:Connected/BSN.Content user or Developer, and I have infrastructure to host a web page.](#i-am-a-baconnectedbsncontent-user-or-developer-and-i-have-infrastructure-to-host-a-web-page)
3. [I am a Developer and would like to see sample code.](#i-am-a-developer-and-would-like-to-see-sample-code)

## I am a BA:Connected/BSN.Content user, but I do not have an option to host a web server

### Node.js App
There are two steps you must take. First, you must add a Node.js App to your presentation:
1. Download the YouTube.zip(LINK) file to your computer.
2. Unzip the file and note the location of the YouTube folder and its content; the folder contains three files: `bundle.js`, `bundle.js.LICENSE.txt`, and `youtube.html`.
3. Open BA:Connected (or BSN.Cloud) and find the presentation you want to update, or create a new presentation.
    - If you make changes to an existing presentation, we strongly recommend creating a copy in case you want to roll your changes back.
4. If you use a BSN.Content subscription:
    - Follow these steps to upload a Node.js App to your Network: https://docs.brightsign.biz/user-guides/content#3s2E5
    - For the **Site Name**, enter `bundle`
    - Leave **Upload as Internal Web Page** unchecked.
    - Select the YouTube.zip file you downloaded in step 1.
    - Under **Select base page for site**, select `YouTube/bundle.js`
    - Click Upload.
5. Expand **Presentation Settings > Support Content > Node.js**.
5. Click the + sign to add a new entry.
6. Under **Node Application Source**:
    - If you use a BSN.Content subscription, select the option labeled `bundle` as noted in step 4 above.
    - If you use BA:Connected without a BSN.Content subscription, find the `bundle.js` file in the YouTube folder from step 2 above, and click OK.
7. Save your changes.

NOTE: This Node.js App launches an Express Server on port 9090. We do not recommend using a single player to host the app for a fleet of players. Instead, leverage existing web server infrastructure and follow the steps from [scenario #2](#i-am-a-baconnectedbsncontent-user-or-developer-and-i-have-infrastructure-to-host-a-web-page).

### Updating your HTML Widgets
The second step involves updating your HTML Widgets/states to use the Node.js App you added to your presentation. 

1. Locate the HTML state you want to update and click it.
2. In **State Properties > Source > Site Source**, ensure `URL` is selected and update the value to the newly constructed URL using the information below as guidance.
3. Save your changes and publish the updated presentation to your player.

### Constructing the video URL
You should already have a URL value in your HTML state that looks like the following: `https://www.youtube.com/embed/VIDEOID?playlist=VIDEOPLAYLISTID&autoplay=1&rel=0&controls=0&showinfo=0&loop=1`. These steps might be easier to complete by copying and pasting the URL value into a text editor such as Notepad, Notepad++, or textEdit in macOS:

1. Delete `https://www.youtube.com/embed/` from the URL and replace it with `http://localhost:9090/youtube.html?videoId=`.
2. Delete the question mark `?` between the `VIDEOID` and the word `playlist=`, and replace with with an ampersand `&`.

The resulting URL should look like the following: `http://localhost:9090/youtube.html?videoId=VIDEOID&playlist=VIDEOPLAYLISTID&autoplay=1&rel=0&controls=0&showinfo=0&loop=1`

## I am a BA:Connected/BSN.Content user or Developer, and I have infrastructure to host a web page

The HTML source code can be downloaded from here < add link >. Then, upload the `youtube.html` file to your web hosting provider or web server. Finally, update your presentation HTML states as described above; when constructing the new video URL, replace `http://localhost:9090` from the instructions with the appropriate value for your web server and include any subfolders in the URL if necessary.

A few things to keep in mind:
- Test the URL using a desktop browser.
- If using `https://` in your URL, ensure any required certificates are installed on the player.
- If using a DNS name or FQDN, ensure the player can resolve it to an IP address.

## I am a Developer and would like to see sample code

Refer to the [src](/src/) folder for a sample autorun.brs script. The script creates an instance of a `roNodeJs` object that launches a simple Express Server on port 9090 to host the `youtube.html` file. Then, it launches a `roHtmlWidget` whose URL points to `http://localhost:9090/` (the local Express Server).

The `youtube.html` file in the [YouTube](/src/YouTube/) folder includes the necessary code to load a YouTube video inside an `iframe`. The JavaScript code parses URL parameters and uses the values to generate the YouTube embed URL for the video.