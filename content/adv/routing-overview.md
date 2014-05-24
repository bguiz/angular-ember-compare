## Routing

Routing is a mechanism which keeps the state of a web application in sync with its URL.
That is, when its URL changes, the application is notified that it should transition to a new state.
Conversely, when the application transitions to a new state, it updates the URL.

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
  they go to a similar state within the web application. Also known as deep linking.
- Deep linking for packaged applications: SPAs can be packaged into native applications,
  using tools such as Phonegap. If a SPA that is packaged within an application
  supports routing, we can deep link to specific parts of that application.

Thus we can see that it is important for us to support routing,
as its absence will detract from the experience and expectations set by existing applications.
Before we take a look at how routing is implemented in AngularJs and EmberJs,
let us look at URLs in single-page applications

### URLs in Single-Page Applications

In single-page applications, the URL is technically always the same,
because technically, we are always on the same page.
We *pretend* to navigate between different pages,
by using JavaScript to replace large sections of the DOM.

However, this would mean that we would lose  the benefits of our application being URL-driven.
Thankfully there are a couple of different techniques to enable routing to occur.

#### Method 1: Hash Fragments

Hash fragments have been around since the early days of the Internet,
pre-dating single-page applications, and even JavaScript!

Their usage was very simple though.
When you had a web page that was rather long, and you wished to link to a different
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
The History API is part of this specification.

It accomplishes something very similar to the hash fragment method,
except that the `#` symbol is no longer present in the URL.
That would mean that the end user would be unable to distinguish
a single page application from a traditional website -
not without firing up the developer's console in a browser anyway.

How the [History API](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history)
accomplishes this is for the server to serve the same file -
the `index.html` of the single page application -
for all URL paths that match its routes.
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

### Routing and State Machines

State machines are a mathematical concept which has found practical application
in a number of things ranging from circuit board design to -
you guessed it - routing in single page applications.

There are two main types of state machines that are of interest to us
in the context of single page applications:
[finite state machines](http://en.wikipedia.org/wiki/Finite-state_machine)
and [hierarchical state machines](http://en.wikipedia.org/wiki/UML_state_machine#Hierarchically_nested_states).

A Finite State Machine is one that defines a number of states that
an application (the *machine*), can be in.
The application is only allowed to be in one state at any point of time.
The finite state machine also must define a series of transitions,
between one state and another, and the triggering conditions for each of them.

A hierarchical state machine is a more complex version of a finite state machine.
It allows any state to define an entire finite state machine within itself.
This may be done recursively, and the end result is a hierarchy of states.
The same rules regarding states and transitions still apply,
however due to the hierarchy, there is one interesting property -
there may be more than one state active at a time.
Between sibling states in one finite state machine,
only one of them may be active at any one point of time, and this still holds true.
However, if this state contains a finite state machine of its own,
amongst its child states, one of them is allowed to be active as well.

This is all rather theoretical - what is the application of
state machines to single page applications?

Routers are objects that provide routing functionality.
Both AngularJs and EmberJs have implemented their routers using state machines.

The router objects store the URL and MVC state for each route in the application
in a state machine.

The state machine is particularly useful in managing transitions between one
route and another; in particular,
transitions come in handy too add hooks to set up or tear down each state.
This would include things like re-rendering a section of the DOM,
and adding/ removing listeners.
These are key parts of "plumbing" type work that a single page application
framework takes care of -
grunt work that happens behind the scenes that would be very tedious
(not to mention boring) to do by hand each time.
Tedious,  but extremely important.
It ensures that the state is correctly in one or another,
and not in some indeterminate or in between state that could be hard to recover from.
It also ensures that the application is performant, and does not suffer from things
such as memory leaks due to stale event listeners for DOM elements that no longer exist.

### Data Retrieval: Callbacks and Promises

When we retrieve data over the network in a single page application,
we use AJAX (asynchronous JavaScript and XML).
The `XMLHttpRequest` global object,
implemented natively in all browsers since IE5,
provides the AJAX functions.
Using the raw `XMLHttpRequest` objects, however, is rather unwieldy,
and in order to avoid having to repeating a lot of cruft code each time
this needs to be done, we use wrapper objects.
AngularJs defines a the `$http` module that fills this role,
while EmberJs uses `jQuery`'s AJAX functions.

JavaScript, however, is has been single threaded<sup>&lowast;</sup> from the get-go,
and this poses a fundamental problem for AJAX, due to its asynchronous nature.
If we were to block execution of the main JavaScript thread
until AJAX requests returned, we would be in for a rather laggy experience on the web.
There is thus a need to be be able to execute code asynchronously.
There are two ways in which this is solved: callbacks and promises.

Callbacks are the de facto way to run JavaScript asynchronously.
As functions are first class objects in JavaScript,
we simply pass in a function that should get executed when the asynchronous code
returns.
That function is referred to as the callback function.
In the case of an AJAX request, the callback function would typically parse or
do something else with the result returned from the server.

That is pretty neat, but callbacks do have their limitations.
Imagine if you wanted to do two tasks that are both asynchronous,
but need the second one to execute only when the first one has completed.
The way to do this would be for the callback function to nest another callback function.
If there are three or more things like this,
you begin to get some really messy code,
characterised by its shape - it looks like a triangle on its side.

Promises overcome this limitation,
by wrapping callback function in promise objects, making it easier to reason
about them in sequences or other types of series and groups.
The more modern JavaScript libraries have embraced promises
as the go to means of dealing with asynchronous code.
AggularJs contains its own promise module,
[`$q`](https://docs.angularjs.org/api/ng/service/$q);
and EmberJs has its own promise library,
[`RSVP`](http://emberjs.com/api/classes/Ember.RSVP.html).
Both implementations follow a common specification, the
[Promises/A+ spec](http://promises-aplus.github.io/promises-spec/),
thus their syntax is almost identical.

<sup>&lowast;</sup> The next edition of the ECMAScript specification, ES6 Harmony,
includes a [proposal for concurrency](http://wiki.ecmascript.org/doku.php?id=strawman:concurrency),
and a [draft for generators](http://wiki.ecmascript.org/doku.php?id=harmony:generators).
The latter, generators, has already been implemented in NodeJs,
and is due to come to browsers shortly.

### Discussion

We have taken a look at what routing is,
and why it continues to be important and relevant in single page applications.
We have also looked at the two different ways in which URLs
work in single page applications: hash fragments and the HTML5 History API.

Finally we have taken a look at the concept of state machines,
and the crucial role that they play in enabling routing
in both AngularJs and EmberJs.
These frameworks use different types of state machines - finite and hierarchical.
impacts the routing functionality that each can support,
and we will examine this in greater detail in the next article.
