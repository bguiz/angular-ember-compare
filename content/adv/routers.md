## Routers

### Routing in AngularJs

Setting up a router - the object responsible for providing routing capability -
is extremely easy in AngularJs:

        App.config(function($routeProvider) {
            $routeProvider
                .when('/foo', {
                    controller: 'FooCtrl',
                    templateUrl: 'foo.template.html'
                })
                .when('/bar', {
                    controller: 'BarCtrl',
                    templateUrl: 'bar.template.html'
                })
                .otherwise({
                    redirectTo: '/foo'
                });
        });

The syntax explains itself (a very good indicator of great design),
but we shall go through it nonetheless.

AngularJs comes with a built-in module,
[`$routeProvider`](https://docs.angularjs.org/api/ngRoute/provider/$routeProvider,
which is in charge of handling routing functionality in the application.
This module merely needs to be configured by the developer.

The `$routeProvider` module should be configured before the application is initialised,
and any other code is run, and therefore this needs to be run during the application's
[configuration phase](http://www.angularjshub.com/examples/modules/configurationrunphases/)
of the application's life cycle.

The configuration consists of pairs of routing information,
where each pair consists of a URL path, an an object from which an MVC state can be derived.
These pairs are passed in by calling `.when()` on the `$routeProvider` object.
The first parameter being the URL path, and the second parameter an object,
which should give AngularJs enough information to derive an MVC state.
Typically this would mean defining a controller and a template:
a view is generated from a template,
and the controller knows how to fetch or construct a model.

### Finite State Machine in AngularJs' Router

AngularJs' choice of a finite state machine places a significant impact on
its routing capability.

In traditional websites, most pages would share common sections,
such as the header, footer, navigation menu, and side bars.
The more complex ones shared more than that -
perhaps the site had several pages dedicated to "Games",
and several pages dedicated to "Stories".
All the "Games" pages would share a certain section,
that would not be present in the "Stories" pages.
Similarly, all the "Stories" pages would share a certain section,
that would not be present in any of the "Games" pages.

In AngularJs, you may apply the `ngView` directive to a DOM element.
When the URL changes, the router determines the new MVC state of the application,
and the contents of the `ngView` element are removed,
and rendered using the new new MVC state.

Since the router is driven by a *finite* state machine under the hood,
there can only be one `ngView` rendered within the application at any time.
This, of course, precludes us from implementing the scenario above,
with the "Games" and "Stories" sections in the scenario described above.

AngularJs developers get around this in one of two ways:

- Simply repeat the content in the templates, and code in the controllers,
  for the states with shared content
- Do not use AngularJs' router, and instead use a 3rd party library,
  [ui-router](https://github.com/angular-ui/ui-router),
  which provides an alternative router that uses a hierarchical state machine.

Some from the AngularJs core team have identified this as a problem,
and have drafted this proposal for
[router design in AngularJs 2.0](https://groups.google.com/forum/#!topic/angular-dev/mO6jmYhvsMk).
It draws inspiration from `ui-router`, EmberJs' router, and a few others.
Thus it appears that the AngularJs may have support for this in
future versions, as there is community support for this.

### Routing in EmberJs

The EmberJs router, and its associated routing concepts,
are significantly more complex than those of AngularJs:

- Supports hierarchical routing, using a hierarchical state machine
- Need to learning naming conventions
- Split of routing responsibility between `Router` and `Route` objects

This added complexity makes for a steeper learning curve at first,
but pays off afterwards, as it supports a richer set of features.

Syntax:

        App.Router.map(function() {
            this.resource('foos', function() {
                this.route('foo', { path: '/:foo_id' });
            });
            this.route('bar');
        });

You might be wondering, but where are the controllers, views, and models named?
To make sense of the syntax for the router,
it is first necessary to understand EmberJs' philosophy on
[convention over configuration](http://en.wikipedia.org/wiki/Convention_over_configuration) -
and in particular, its naming conventions.

### Convention over Configuration in EmberJs

When you instantiate a new EmberJs application using

        var App = Ember.Application.create({});

The framework will create a `Router` object.
This is the first or many naming conventions to come!

We then call the `Router.map()` function,
and pass in a function that defines a hierarchy of routes,
using `this.resource` for routes that have child nodes,
and `this.route` for leaf nodes.
Both `.resource()` and `.route()` take in a string as their first parameter,
and it is the value of this string that EmberJs uses to determine which
`Route`, `Controller`, `View`, and template objects it shall use.
The way it works these out are not immediately obvious,
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
Once that happens, it becomes less of a hindrance,
and more of a boon to productivity,
as it does, by definition, mean less cookie cutter code that needs to be written.

### Hierarchical State Machine in EmberJs' Router

EmberJs uses a hierarchical state machine in its router implementation.
This is evident when inspecting the code that we use to configure the router:
In AngularJs all the calls to `.when()` on `$routeProvider` are at the same level.
However, in EmberJs, within `.map()` we call `.resource()` and `.route()`,
in a nested manner - and this is how we configure the hierarchical states.

The first argument in each `.resource()` and `.route()` is a string,
and by default, the URL for any `resource` or `route` is obtained by
joining these strings together, in all nodes down the hierarchy.
For example:

        App.Router.map(function() {
            // URL is /foo
            this.resource('foo', function() {
                // URL is /foo/bar
                this.resource('foo.bar', function() {
                    // URL is /foo/bar/baz
                    this.route('baz');
                });
            });
        });

While assembling a URL like this is pretty easy - just string concatenation -
assembling a composite MVC state from a hierarchy of routes is not quite that easy.
Thankfully, EmberJs does this all for us, however,
as developers it is important for us to understand what it does here,
so as to use it correctly.

First let us go back to hierarchical state machines.
Recall that a hierarchical state machine is a finite state machine,
where each state is allowed to contain, within it,
an entire finite state machine of its own,
and this is allowed to recur to produce multiple levels of hierarchy.
Using the following hierarchy as an example:

- info
- games
    - pacman
    - snake
- stories
    - watchmen
    - holes

In this case, the top level finite states are `info`, `games`, and `stories`.
Both of `games` and `stories` contain child states.
When switching between top level states,
or child states that belong to the same top level state,
such as `info --> games` or `games.pacman --> games.snake`,
we are moving within the same finite state machine,
and thus the behaviour is not very complex.

When moving across different finite state machines, however,
the process is a little more complex.
For example `games.pacman --> stories.watchmen` means that three different
transitions need to occur:

1. exit state `games.pacman`
2. exit state `games` and enter state `stories`
3. enter state `stories.pacman`

It is important to visualise which states are active,
before and after moving between one route and another.
EmberJs keeps all the current routes, models, views, templates, and controllers,
for all the state that do not change before and after the transition intact,
tears down those that have been exited from,
and sets up those that have been entered.

The developer does not really have much control over this behaviour,
and should be aware of when these actions occur,
and add code to be executed upon life cycle hooks of each of them when necessary.
[Life cycle Hooks in Views](http://emberjs.com/guides/understanding-ember/the-view-layer/#toc_lifecycle-hooks)
Controllers are only instantiated once, and their life cycle is managed by
`Route` objects - via
[`model`, `beforeModel`, and `afterModel`](http://emberjs.com/guides/routing/preventing-and-retrying-transitions/#toc_aborting-transitions-within-code-model-code-code-beforemodel-code-code-aftermodel-code),  `setupController`, and
[`willTransition`](http://emberjs.com/guides/routing/preventing-and-retrying-transitions/#toc_preventing-transitions-via-code-willtransition-code).

Templates, being defined using markup instead of JavaScript,
are quite different.
For multiple templates to be active at once, in a hierarchy,
each template must define where within it its child template should be placed.
This is accomplished using the `{{outlet}}` Handlebars helper.
Think of it as telling the template that,
when there is a child state that is active on the current route,
this is where it should be rendered.
While this is a very simple thing to do,
when combined with the power of EmberJs' routing,
it can be used to accomplish some types of layouts that would be otherwise hard to do,
including the master-detail pattern, where the UI displays a list of item,
with perhaps just the name in one section of the page (the master),
and when each of these is clicked on,
all the information about that item is displayed in another section of the page (the detail).

This article by UX Magazine on
[application screen design](http://uxmag.com/articles/rich-internet-application-screen-design)
lists quite a number of the most common screen layouts in user interfaces.
Many of these are only possible when the software rendering them supports
the concept of view hierarchies.

I have put together this JsBin to
[demonstrate hierarchical routing in EmberJs](http://jsbin.com/wiyin/4/edit?html,js,output),
so as the short in-line code examples do not really do this justice.

### Routes in EmberJs

Routing in EmberJs is implemented through one `Router` object,
and multiple `Route` objects.
The primary functions of a `Route` object are to fetch or construct
the MVC state of the application when activated.
Typically this would involve fetching the model,
then passing the model to the controller,
and finally telling the view to render its template.

The default implementation of the `Route` object does all of these things,
out of the box, without the developer having to do anything.
The model however, will simply be empty.
In most cases, we want our routes to have models,
and fetch these models from a server.
Thus, typically the default routes are extended
to implement a custom `model` hook.

        App.FoosRoute = Ember.Route.extend({
            model: function() {
                return [{name: 'f1'}, {name: 'f2'}, {name: 'f3'}];
            }
        });

That controller always returns an array with hard-coded contents.
Useful for stubbing or prototyping, but for applications in production,
most likely we will want to retrieve data from an external data source,
such as an API server:

        App.FoosRoute = Ember.Route.extend({
            model: function() {
                var req = Ember.RSVP.resolve(Ember.$.getJSON('/api/foos'));
                return req.then(function resolve(response) {
                    return response.foos;
                });
            }
        });

Here we use [`jQuery.getJSON()`](http://api.jquery.com/jquery.getjson/)
to perform the AJAX request.
AJAX requests, are, of course, asynchronous,
and thus they need to be dealt with using either callbacks or promises.
In EmberJs, the `model` hook of any route is expected to return one of two types:

- a plain ol' JavaScript object (POJSO)
- a promise

If a POJSO is returned, EmberJS uses that value immediately.
If, on the other hand, a promise is returned,
EmberJs waits until the promise resolves or rejects,
and only then does it continue (initialise the controller and pass the model to it).

Above we need to wrap the promise-like object returned by `jQuery.getJSON()`
using `Ember.RSVP.resolve()` in order to obtain a promise object that EmberJs
knows how to use correctly.
This is yet another stumbling block for anyone starting with EmberJs,
because it quite often means that the application does not work as expected.
It would be great if this is better documented in EmberJs,
or better still, if EmberJs ships with its own AJAX constructs,
as AngularJs does with its `$http` modules.

### Discussion

When it comes to routing, the solution offered by EmberJs is far more powerful
than the solution provided by AngularJs.
This comes at the expense of complexity -
grokking EmberJs' router and route objects can be extremely exasperating
for those just starting out,
and a lot of that stems from not yet being familiar with the naming system.
Once past that hurdle, there is yet more additional complexity inherent in
understanding hierarchical state machines and applying that
when designing the structure of the routes (and therefore the rest of the application).

AngularJs, on the other hand, provide a much simpler and easier means
to define routing for the application.
If the application does not require all that added complexity,
such as hierarchical views,
then this offers a much better proposition.
