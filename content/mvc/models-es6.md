### How this might change with ES6

There is currently [a draft proposal in ECMAScript 6](http://wiki.ecmascript.org/doku.php?id=harmony:observe,
the standards specification for the next version of JavaScript,
for `Object.observe()`.
The specification calls for native methods on all POJSOs to observe for
changes made to their state.
This ability will turn the issue of wrapper objects with accessors versus
dirty checking on its head,
as both of them will no longer be necessary to listen for changes in models,
and to accomplish data-binding between models and views.
This article, even goes as far as to say ["Everything you think you know about data binding — and every trick MVC libraries are using to pull it off — is about to be flipped on its head"](http://bocoup.com/weblog/javascript-object-observe/).

It is pertinent to remember, that while some browsers, as well as NodeJs,
have already implemented `Object.observe()`,
it is still under discussions, and is still presently a proposal,
not yet an official specification, so actual implementation variations,
and adoption across all devices, is still relatively unknown.

### Discussion

We have taken a look at how to use models, and how to sync them with a server,
in both AngularJs and EmberJs.
There are quite a few significant differences between them.

As we will soon see,
AngularJs and EmberJs have different philosophies regarding opinionation.
AngularJs leans towards providing many different ways to accomplish a task,
and let the developer choose which one fits their needs best.
Providing multiple ways to do sync models with the server is exactly what
you would expect.

EmberJs, on the other hand, leans towards choosing the one best,
or [*omakase*](https://twitter.com/tomdale/status/285821254928322561 "Omakase (お任せ, o-makase) is a Japanese phrase that means I'll leave it to you (from Japanese to entrust (任せる, makaseru))."),
way of doing something, and requiring all developers to follow that.
In most facets of a SPA framework,
the EmberJs team has come up with this *omakase* way to do things.
However, it appears that they are still figuring out the best way
for how to sync models with the server.
Having different ways to accomplish this runs orthogonal to this philosophy.

The most significant difference between AngularJs models and EmberJs models,
is the mechanism that each framework uses to observe changes on them.
The pros and cons of the approach chosen by each framework:

- AngularJs uses dirty checking:
    - Dead simple syntax (identical to POJSOs)
    - Incurs a heavy performance penalty when number of models for model complexity becomes large
- EmberJs uses wrapper objects with accessors
    - More complex, verbose syntax
    - Incurs a much lighter performance penalty when number of models for model complexity becomes large

When the draft specification for `Object.observe()` gets formalised,
we will expect all of this to change,
as it will obviate the need for both wrapper objects with accessors, and dirty checking.

Models, however, are not very useful on their own.
Users cannot interact with them.
In order to display models, we need views, the *V* in MVC,
and we will be taking a look at them next.
