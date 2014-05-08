## Router

Routing is a mechanism which keeps the state of a web application in sync with its URL.
That is, when its URL changes, the app is notifiied that it should transition to a new state.
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

