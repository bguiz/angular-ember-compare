# Routing

![Routing in SPAs](/images/spa-routing.png)

Routing is a mechanism which keeps the **state** of a web application
**in sync with its URL**.
That is, when its URL changes, the application is notified that it should transition to a new state.
Conversely, when the application transitions to a new state, it updates the URL.

If this sounds like familiar territory, that is because it is!
Whenever using a traditional website -
where the page refreshes upon each navigation -
this is precisely what happens.
One page for one URL.

However, when building a single page application,
we do not get this by default, and the SPA framework,
such as AngularJs or EmberJs,
needs to mimic this behaviour without actually changing pages.
Before we get into that, however, let us take a step back,
to understand why routing is important,
and why it continues to be relevant with the advent of single page applications.

- **Expectation**: Routing is what we are already used to when browsing the web;
  when we navigate to a different "page" we expect it to have a different URL
- **Browser history**: We expect to be able to use the back and forward buttons
  while browsing web sites
- **URL sharing**: We have an expectation that by copying the URL from the browser's
  address bar, and sharing that with others, when they open that URL,
  they go to a similar state within the web application. Also known as deep linking.
- **Deep linking for packaged applications**: SPAs can be packaged into native applications,
  using tools such as Phonegap. If a SPA that is packaged within an application
  supports routing, we can deep link to specific parts of that application.

Thus we can see that it is important for us to support routing,
as its absence will detract from the experience and expectations set by existing applications.
Before we take a look at how routing is implemented in AngularJs and EmberJs,
let us look at URLs in single-page applications
