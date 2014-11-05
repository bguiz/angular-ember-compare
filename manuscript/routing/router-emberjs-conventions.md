## Convention over Configuration in EmberJs

When you instantiate a new EmberJs application using

        var App = Ember.Application.create({});

The framework will create a `Router` object.
It is always named `Router`, no ifs, no buts.
This is the first of many **naming conventions** to come!

We then call the `Router.map()` function,
and pass in a function that defines a hierarchy of routes,
using `this.resource` for routes that have child nodes,
and `this.route` for leaf nodes.
Both `.resource()` and `.route()` take in a string as their first parameter,
and it is the value of this string that EmberJs uses to determine which
`Route`, `Controller`, `View`, and template objects it should use.
The way it works these out may not be immediately obvious,
and this guide serves as a good primer:
[EmberJs routes guide](http://emberjs.com/guides/routing/defining-your-routes/).

The key take away here is that the router object may be thought of as a
*king* object in any EmberJs application.
Whatever names it uses for its routes determine the names of
all the other types of EmberJs objects.
When starting out in EmberJs for the first time,
this can be incredibly frustrating,
as it takes a little getting used to at first,
and until then a name that is slightly wrong means that EmberJs does not detect
it at all, and simply falls back on using a default or generic implementation
of that object.
For example naming a controller `FooBarCtrl` instead of `FooBarController`,
or naming a template `foo-bar` instead of `foo/bar`.

Know that you are not alone when you are left scratching your head,
thinking why your code does not appear to have any effect -
instead refer to the
[routes guide](http://emberjs.com/guides/routing/defining-your-routes/)
once more and double check that all the naming conventions have been adhered to.

Convention over configuration can, and most likely will,
be frustrating to any developer;
but only up until the point that you get used to it.
Once past that hurdle, it becomes less of a hindrance,
and more of a boon to productivity,
as it does, by definition,
result in having to write less cookie cutter code.
