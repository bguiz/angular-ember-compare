# AngularJs vs EmberJs

So you want to start building a single-page application.
Which framework should you use to help build it?

![AngularJs vs EmberJs](/images/angularjs-emberjs.png)

This series of articles takes a look at two of the most popular ones:
[AngularJs](http://angularjs.org/) and
[EmberJs](http://emberjs.com/)

## The back story

While developing applications using BackboneJs, I have been itching to use a newer JavaScript single-page application (SPA) framework;
if at least to find out if it was indeed worth continuing to develop with the tried-and-tested, battle proven,
but often verbose and feature lacking,
[BackboneJs](http://backbonejs.org/).

At first, I had wanted to compare all the SPAs.

![Learn All the SPAs!](/images/learn-all-the-spas.png)

However, that meant I would be spreading myself too thin.
Besides, we already have [TodoMVC](http://todomvc.com/) for that.

What I really wanted to do was to take the two most popular SPAs after BackboneJs,
and analyse them in depth -
pitting them against each other, and taking a look at the pros and cons of each.

Given that they both fall into the same broad category,
and are designed to help developers accomplish similar end goals,
I expected them to be quite similar.

Interestingly, they were not.
It was not just the syntax that was different.
I found that they have very different philosophies on
how code should be structured,
and even how much structure there should be;
making for quite an interesting comparison.

Let us take a look!

## Editions

The **online edition** of this book is available at
[angularjs-emberjs-compare.bguiz.com](http://angularjs-emberjs-compare.bguiz.com).

The **PDF, ePub, and Mobi editions** of this book are available at
[Leanpub](https://leanpub.com/angularjs-emberjs-compare?a=27hVMyWVn46xaZCi6E563X&subID=gitbookb).

[![AngularJs vs EmberJs on Leanpub](/images/title_page_small_shadow.png)](https://leanpub.com/angularjs-emberjs-compare?a=27hVMyWVn46xaZCi6E563X&subID=gitbookbc)

If you liked this book, and wish to support it,
please purchase a copy on Leanpub.
10% of proceeds are donated to the
[Electronic Frontier Foundation](https://www.eff.org/).
The online edition of this book is free, and will always remain free.

## Author

Hi, I'm Brendan Graetz. You can find me on [Twitter](https://twitter.com/bguiz "Follow @bguiz"):

<a href="https://twitter.com/bguiz" class="twitter-follow-button" data-show-count="false" data-size="large">
   Follow @bguiz
</a>
<script>
    !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
</script>

... and on [Github](https://github.com/bguiz)

<iframe src="http://ghbtns.com/github-btn.html?user=bguiz&type=follow"
    allowtransparency="true" frameborder="0" scrolling="0" width="132" height="20">
</iframe>

... and on [LinkedIn](https://www.linkedin.com/in/brendangraetz "Brendan Graetz on LinkedIn")

<a href="https://www.linkedin.com/in/brendangraetz">
<img src="http://s.c.lnkd.licdn.com/scds/common/u/img/webpromo/btn_viewmy_160x33.png" width="160" height="33" border="0" alt="View Brendan Graetz's profile on LinkedIn">
</a>

I also blog at [blog.bguiz.com](http://blog.bguiz.com),
where you can check out my other writing.
