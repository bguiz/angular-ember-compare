require(["gitbook"], function(gitbook) {
    var leanpubAffiliateConfig, leanpubAffiliateData;

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
    function pickAds(num) {
        var foo = [], ads = [];
        for (var i = 0; i < leanpubAffiliateData.length; ++i) {
           foo.push(i);
        }
        for (var j = 0; j < num; ++j) {
            var idx = getRandomInt(0, foo.length -1);
            ads.push(leanpubAffiliateData[foo[idx]]);
            foo.splice(idx, 1);
        }
        return ads;
    }

    function reload() {
        var el = document.querySelector('.gitbook-leanpub-affiliate');
        if (!el) {
            console.error('unable to find element for leanpub affiiliate');
            return;
        }
        var config = leanpubAffiliateConfig;
        var widthPercent = Math.floor(90 / config.count);
        var widthPixels = Math.floor(config.image.width);
        var out = '\n\n<br /><hr />';
        var ads = pickAds(config.count);
        for (var c = 0; c < ads.length; ++c) {
            var ad = ads[c];
            out += '<a href="'+ad.url+config.queryString+'" class="gitbook-leanpub-affiliate-link" '+
                'style="max-width: '+widthPercent+'%; min-width: '+widthPixels+'px;">';
            if (config.image.display) {
                out += '<img width="'+config.image.width+'" height="'+config.image.height+
                    '" src="'+ad.image+'" class="gitbook-leanpub-affiliate-cover" /><br />';
            }
            out +=
                '<span class="gitbook-leanpub-affiliate-text">'+
                    '<span class="gitbook-leanpub-affiliate-text-title">'+ad.title+'</span><br />'+
                    '<span class="gitbook-leanpub-affiliate-text-author">by '+ad.author_string+'</span>'+
                '</span></a>\n';
        }

        out += '<hr />\n\n';
        el.innerHTML = out;
    }

    gitbook.events.bind("start", function(e, config) {
        leanpubAffiliateConfig = config.leanpubAffiliate || {};
        leanpubAffiliateData = leanpubAffiliateConfig.ads || [];
        reload();
    });

    gitbook.events.bind("page.change", function() {
        leanpubAffiliateConfig = leanpubAffiliateConfig || {};
        if (leanpubAffiliateConfig.ads) {
            leanpubAffiliateData = leanpubAffiliateConfig.ads || [];
            reload();
        }
    });

    gitbook.events.bind("exercise.submit", function(e, data) {});
});
