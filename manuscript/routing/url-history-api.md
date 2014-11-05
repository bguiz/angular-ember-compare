### History API

More recently, however, browsers have started implementing the HTML5 specification.
The History API is part of this specification.

It accomplishes something very similar to the hash fragment method,
except that the `#` symbol is no longer present in the URL.
That would mean that the end user would be unable to distinguish
a single page application from a traditional website -
not without firing up the developer's console in a browser anyway.

How the [History API](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history)
accomplishes this is for the server to serve the same file -
the `index.html` of the single page application -
for **all** URL paths that match its routes.
Subsequently the SPA itself will use the functions in the
History API to alter the URL in the address bar,
*without* reloading the page.
It also also listens for changes in the URL in the address bar,
and intercept them *before* a new request is made on the server.
This is a little tricky to make work with a single page application,
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
