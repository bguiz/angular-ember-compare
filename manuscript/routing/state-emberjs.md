## Hierarchical State Machine in EmberJs' Router

EmberJs uses a hierarchical state machine in its router implementation.
This is evident when inspecting the code that we use to configure the router:
In AngularJs all the calls to `.when()` on `$routeProvider` are at the same level.
However, in EmberJs, within `.map()` we call `.resource()` and `.route()`,
in a **nested manner** - and this is how we configure the hierarchy of states.

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
assembling a **composite MVC state** from a **hierarchy of routes** is not quite that easy.
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

In this case, the top level finite state machine contains the states `info`, `games`, and `stories`.
Both of `games` and `stories` contain child finite state machines.
Each of these child finite state machines contains two states.
Thus both `games` and `stories` have two child states.

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
EmberJs keeps all the current routes, models, views, templates, and controllers intact,
for all the states that **do not change** before and after the transition,
tears down those that have been exited from,
and sets up those that have been entered.

The developer does not really control this behaviour,
but should be aware of when these actions occur,
and add code to be executed upon life cycle hooks of each of them when necessary.

- [Life cycle Hooks in Views](http://emberjs.com/guides/understanding-ember/the-view-layer/#toc_lifecycle-hooks)

Controllers are only instantiated once, and their life cycle is managed by
`Route` objects, via:

- [`model`, `beforeModel`, and `afterModel`](http://emberjs.com/guides/routing/preventing-and-retrying-transitions/#toc_aborting-transitions-within-code-model-code-code-beforemodel-code-code-aftermodel-code),
- `setupController`, and
- [`willTransition`](http://emberjs.com/guides/routing/preventing-and-retrying-transitions/#toc_preventing-transitions-via-code-willtransition-code).

Templates, being defined using markup instead of JavaScript,
are quite different.
For multiple templates to be active at once, in a hierarchy,
each template must define where within it its child template should be placed.
This is accomplished using the `{{outlet}}` Handlebars helper.
Think of it as telling the template that,
when there is a child state that is active on the current route,
here is *where* it should be rendered.

While this is a very simple thing to do,
when combined with the power of EmberJs' routing,
it can be used to accomplish some types of user interface layouts that would be otherwise hard to do,
including the **master-detail pattern**, where the UI displays a list of items,
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
as the short in-line code examples do not really do this justice.
