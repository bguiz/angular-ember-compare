require(["gitbook"], function(gitbook) {

	var redditButton = '<script type="text/javascript" src="http://www.reddit.com/static/button/button1.js"></script>';
	var redditButtonCreate = function() {
	  if ('https:' == document.location.protocol) {
	      var base_url = 'https://redditstatic.s3.amazonaws.com'
	  } else {
	      var base_url = 'http://www.reddit.com/static'
	  }

	  var write_string="<iframe src=\"" + base_url + "/button/button1.html?width=120&url=";

	  if (window.reddit_url)  { 
	      write_string += encodeURIComponent(reddit_url); 
	  }
	  else { 
	      write_string += encodeURIComponent(window.location.href);
	  }
	  if (window.reddit_title) {
	       write_string += '&title=' + encodeURIComponent(window.reddit_title);
	  }
	  if (window.reddit_target) {
	       write_string += '&sr=' + encodeURIComponent(window.reddit_target);
	  }
	  if (window.reddit_css) {
	      write_string += '&css=' + encodeURIComponent(window.reddit_css);
	  }
	  if (window.reddit_bgcolor) {
	      write_string += '&bgcolor=' + encodeURIComponent(window.reddit_bgcolor); 
	  }
	  if (window.reddit_bordercolor) {
	      write_string += '&bordercolor=' + encodeURIComponent(window.reddit_bordercolor); 
	  }
	  if (window.reddit_newwindow) { 
	      write_string += '&newwindow=' + encodeURIComponent(window.reddit_newwindow);}
	  write_string += "\" height=\"22\" width=\"120\" scrolling='no' frameborder='0'></iframe>";
	  // document.write(write_string);
	  return write_string;
	}

	var shareConfig;
	var reloadShare = function() {
        if (shareConfig.reddit) {
            // var out = '<script type="text/javascript" src="http://www.reddit.com/static/button/button1.js"></script>';
        	var out = redditButtonCreate();
        	$(".gitbook-share").append($(out));
        }
	};

    gitbook.events.bind("start", function(e, config) {
        shareConfig = config.share || {};
    	reloadShare();
    });

    gitbook.events.bind("page.change", function() {
        shareConfig = shareConfig || {};
    	reloadShare();
    });

    gitbook.events.bind("exercise.submit", function(e, data) {
    });
});