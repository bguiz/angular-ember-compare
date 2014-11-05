## A brief history of single-page applications

**Time line**:

- One page load per navigation
- Add AJAX
- Web 2.0
- Add MVC patterns
- Single-page applications

In the early days of the web, all web sites made one request to the server,
and the server responded with the entire web page to be displayed.
Query parameters, cookies, and request headers were just about all a web developer had
in his or her toolkit with which interactivity could be accomplished.
Web servers did all the grunt work rendering dynamic web pages.

This all changed when Microsoft [released IE5 with `XMLHttpRequest`](http://en.wikipedia.org/wiki/XMLHttpRequest#Support_in_Internet_Explorer_versions_5.2C_5.5.2C_and_6),
which was a means to send a request to the server and receive the request.
This was the first time that this could be done entirely using JavaScript run within a web page.
This was a **game changer**.

At first, this was used to simply swap the contents of one `<div>` on the page verbatim with the returned response.
Responses were originally HTML fragments to be used as such.
This then evolved to XML to represent data that would be parsed by JavaScript in the browser.
This went by the name of *Asynchronous JavaScript and XML*,
or [AJAX](http://en.wikipedia.org/wiki/Ajax_(programming)).
Processing XML in JavaScript was a little unwieldy,
and it was much easier to transmit JavaScript object literals instead.
Douglas Crockford [specified the JSON format](http://en.wikipedia.org/wiki/JSON#History),
which gained rapid following.
Most AJAX nowadays uses JSON instead of XML,
so we should really be calling in *AJAJ* - but the original name stuck.

[![Web 2.0](/images/320px-Web_2.0_Map.svg.png)](http://en.wikipedia.org/wiki/Web_2.0)

This disrupted the status quo of one page load per request,
and created an explosion in the amount of interactivity possible on a page.

Web developers did exactly that, making their sites very interactive,
and thus was born the era of "Web 2.0" web sites.
However the client-side JavaScript quite often ended up becoming a tangled mess of unstructured JavaScript -
and later on a tangled mess of jQuery -
whenever the sites tried to do something complex.

However, server side developers had been using the MVC pattern for some time now,
and there was no reason to not do so client side as well.
After all, since web sites were no longer thin-clients,
JavaScript was being used for more than a few simple updates to the DOM,
it was taking over some or all of the core logic of the web site.
It thus became pertinent to add some organisation and structure to the JavaScript.

The thing about JavaScript is that it is a strange beast.
It has weird quirks that make it behave quite unexpectedly,
such as [automatic semicolon insertion](http://bonsaiden.github.io/JavaScript-Garden/#core.semicolon),
and an [unpredictable equality operator](http://dorey.github.io/JavaScript-Equality-Table/unified/).
It also has some really advanced concepts like [closures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Closures) and
[prototypical inheritance](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Inheritance_and_the_prototype_chain),
which make it very powerful, but also make attaining true mastery a longer journey.
Lastly, it supports both imperative and functional programming paradigms.

With all these actors stewing in the same broth,
there were **many many different ways** to accomplish the same things.
There were many way to accomplish very similar things.
Addy Osmani's [JavaScript Design Patterns](http://addyosmani.com/resources/essentialjsdesignpatterns/book/#designpatternsjavascript) captures the most popular amongst them.
This ultimately resulted in a "Wild West", where everyone did their own thing.

Building complex user interfaces and interfacing with a server is indeed an onerous task.
It thus increasingly became important to use a framework when developing web applications.
Take a look at the source code of [BackboneJs](https://github.com/jashkenas/backbone/),
[AngularJs](https://github.com/angular/angular.js/), or
[EmberJs](https://github.com/emberjs/ember.js/),
to get a feel for how much work would be involved in rolling your own.

There were several frameworks to come out before it did,
but BackboneJs was the first to really nail it.
It combined the use of AJAX with MVC patterns in a JavaScript library that
allowed front end developers to create a single-page application -
an application where every page simply used JavaScript to re-render
(most of) the visible page in the client,
and none of the requests navigated you away from `index.html`
(thus the "single page" in "single page application").

This combination of AJAX and the MVC pattern is the cornerstone of single-page application frameworks.
BackboneJs was merely the first of many SPA frameworks to gain widespread popularity.
There a currently are [plethora of different frameworks](http://todomvc.com)
looking to take its place.
AngularJs and EmberJs are two of them.
