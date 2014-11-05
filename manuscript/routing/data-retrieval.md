## Data Retrieval: Callbacks and Promises

When we retrieve data over the network in a single page application,
we use AJAX (asynchronous JavaScript and XML).
The `XMLHttpRequest` global object,
implemented natively in all browsers since IE5,
provides the AJAX functions.
Using the raw `XMLHttpRequest` object, however, is rather unwieldy,
and in order to avoid having to repeating a lot of cruft code each time
this needs to be done, we use wrapper objects.
AngularJs defines a the `$http` module that fills this role,
while EmberJs uses `jQuery`'s AJAX functions.

JavaScript, however, has been single threaded<sup>&lowast;</sup> from the get-go,
and this poses a fundamental problem for AJAX, due to its asynchronous nature.
If we were to block execution of the main JavaScript thread
until AJAX requests returned, we would be in for a rather laggy experience on the web.
There is thus a need to be be able to execute code asynchronously.
There are two ways in which this is solved: callbacks and promises.

### Callbacks

Callbacks are the de facto way to run JavaScript asynchronously.
As functions are first class objects in JavaScript,
we simply pass in a function that should get executed when the asynchronous code
returns.
That function is referred to as the callback function.
In the case of an AJAX request, the callback function would typically parse or
do something else with the result returned from the server.

That is pretty neat, but callbacks do have their limitations.
Imagine if you wanted to do two tasks that are both asynchronous,
but need the second one to execute only *after* the first one has completed.
The way to do this would be for the callback function to nest another callback function within itself.
If there are three or more things like this,
you begin to get some really messy code,
characterised by its shape - it looks like a triangle on its side.
This known as "*callback hell*".

### Promises

Promises overcome this limitation,
by wrapping callback function in promise objects, making it easier to reason
about them in sequences or other types of series and groups.
The more modern JavaScript libraries have embraced promises
as the go to means of dealing with asynchronous code.
AngularJs contains its own promise module,
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
