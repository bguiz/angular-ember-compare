(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-37884921-4', 'bguiz.com');
ga('send', 'pageview');

require(["gitbook"], function(gitbook) {
    gitbook.events.bind("start", function(e, config) {
        config.ga = config.ga || {};

        ga('send', 'pageview');
    });

    gitbook.events.bind("page.change", function() {
        ga('send', 'pageview');
    });

    gitbook.events.bind("exercise.submit", function(e, data) {
        
    });
});