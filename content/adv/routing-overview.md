## Routing

Routing is a mechanism which keeps the state of a web application in sync with its URL.
That is, when its URL changes, the app is notified that it should transition to a new state.
Conversely, when the app transitions to a new state, it updates the URL.

If this sounds like familiar territory, that is because it is!
Whenever using a traditional website -
where the page refreshes upon each navigation -
this is precisely what happened.
One page, one URL.

However, when building a single page application,
we do not get this by default, and the SPA framework,
such as AngularJs or EmberJs, needs to take care of this for us.
Before we get into that however, let us take a step back,
to understand why routing is important,
and why it continues to be relevant with the advent of single page applications.

- Routing is what we are already used to when browsing the web;
  when we navigate to a different "page" we expect it to have a different URL
- Browser history: We expect to be able to use the back and forward buttons
  while browsing web sites
- URL sharing: We have an expectation that by copying the URL from the browser's
  address bar, and sharing that with others, when they open that URL,
  they go to a similar state within the web app. Also known as deep linking.
- Deep linking for packaged apps: SPAs can be packaged into native apps,
  using tools such as Phonegap. If a SPA that is packaged within an app
  supports routing, we can deep link to specific parts of that app.

Thus we can see that it is important for us to support routing,
as its absence will detract from the experience and expectations set by existing apps.
Before we take a look at how routing is implemented in AngularJs and EmberJs,
let us look at URLs in single-page applications

### URLs in Single-Page Applications

In single-page applications, the URL is technically always the same,
because technically, we are always on the same page.
We *pretend* to navigate between different pages,
by using Javascript to replace large sections of the DOM.

However, this would mean that we would lose  the benfits of our app being URL-driven.
Thankfully there are a couple of different techniques to enable routing to occur.

#### Method 1: Hash Fragments

Hash fragments have been around since the early days of the Internet,
predating single-page applications, and even Javascript!

Their usage was very simple though.
When you had a webpage that was rather long, and you wished to link to a different
section on the same page, rather than to a different page,
you would do something like this, in your HTML:

        <a href="#partOfPageManyScrollsAway">
            Clicking here will jump to a part of the page that is many scrolls away
        </a>

&hellip; and somewhere else *in the same document*, we will have:

        <a name="partOfPageManyScrollsAway">
            You sure got here quickly!
        </a>

As you may have guessed, clicking on the first `<a>` tag
would scroll the second `<a>` tag into view in the browser.

&hellip; but that is not all!
If you look in the address bar, you will find that the URL has been suffixed with
`#partOfPageManyScrollsAway`.
When you click on the back button,
you go back to where you were originally within the page - the first `<a>` tag
When you click the forward button now,
you go back to the second `<a>` tag again.

You can try this out for yourself!
Go to any article of [Wikipedia](http://en.wikipedia.org)
and find citations in line with the text.
Many of these are hyperlinks to other `<a>` tags
that are at the bottom of the page, in the list of citations.
Click on a few of these in a row, and then use the back and forward buttons.

This was the only way (until recently),
where the browser's URL could change without navigating to a different page,
**and** forward and back buttons continue working (browser history preserved).
Given this, the developers of SPA frameworks decided to use this as the means
to store the URL of SPA's current route.
That is, as far as the SPA was concerned, it own internal URL was the hash fragments.
Thus, instead of using words and numbers in hash fragments,
they simply used the URL path instead.
For example: `#/foo/123` or `#/bar/123/edit`

#### Method 2: History API

More recently, however, browsers have started implementing the HTML5 specification.
The History API is part of this spec.

It accomplishes something very similar to the hash fragment method,
except that the `#` symbol is no longer present in the URL.
That would mean that the end user would be unable to distinguish
a single page application from a traditional website -
not without firing up the developer's console in a browser anyway.

How the [History API](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history)
accomplishes this is for the server to serve the same file -
the `index.html` of the single page app -
for all URL paths that match its routes.
Subsequently the SPA itself will use the functions in the 
History API to alter the the URL in the address bar,
*without* reloading the page.
It also also listens for changes in the URL in the address bar,
and intercept them *before* a new request is made on the server.
This is a little tricky to make work with a single page app,
but we do not need to re-invent the wheel,
as both AngularJs and EmberJs come with this built in.

This is a clear improvement on the hash fragment method,
but there is a catch: not all browsers support it -
only the more recent versions of each do.
See [this chart](http://caniuse.com/history)
for the exact browsers and versions.

The History API is an improvement on hash fragments,
and we should try to use it where we can,
and fall back on hash fragments in other cases.
