require(["gitbook"], function(gitbook) {

	var facebookButtonCreate = function(cfg) {
		var loc = '//www.facebook.com/plugins/like.php?href='+
			encodeURIComponent(cfg.url ? cfg.url : window.location.href) +
			'width='+(cfg.width ? cfg.width : 120)+
			'&layout='+(cfg.layout ? cfg.layout : 'button_count')+
			'&action=like&show_faces=false&share=true&height=21'+
			(cfg.appId ? '&appId='+cfg.appId : '');
		var out = '<iframe src="' + loc + '" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe>';
		return out;
	};

	var redditButtonCreate = function(cfg) {
	  if ('https:' == document.location.protocol) {
	      var base_url = 'https://redditstatic.s3.amazonaws.com'
	  } else {
	      var base_url = 'http://www.reddit.com/static'
	  }

	  var write_string="<iframe src=\"" + base_url + "/button/button1.html?width=120&url=";

	  if (cfg.url)  { 
	      write_string += encodeURIComponent(cfg.url); 
	  }
	  else { 
	      write_string += encodeURIComponent(window.location.href);
	  }
	  if (cfg.title) {
	       write_string += '&title=' + encodeURIComponent(cfg.title);
	  }
	  if (cfg.target) {
	       write_string += '&sr=' + encodeURIComponent(cfg.target);
	  }
	  if (cfg.css) {
	      write_string += '&css=' + encodeURIComponent(cfg.css);
	  }
	  if (cfg.bgcolor) {
	      write_string += '&bgcolor=' + encodeURIComponent(cfg.bgcolor); 
	  }
	  if (cfg.bordercolor) {
	      write_string += '&bordercolor=' + encodeURIComponent(cfg.bordercolor); 
	  }
	  if (cfg.newwindow) { 
	      write_string += '&newwindow=' + encodeURIComponent(cfg.newwindow);
	  }
	  write_string += "\" height=\"22\" width=\"120\" scrolling='no' frameborder='0'></iframe>";
	  return write_string;
	}

	var shareConfig;
	var reloadShare = function() {
        if (shareConfig.reddit) {
            var out = redditButtonCreate(shareConfig.reddit);
        	$(".gitbook-share").append($(out));
        }
        if (shareConfig.facebook) {
        	var out = facebookButtonCreate(shareConfig.facebook);
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