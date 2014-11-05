## Discussion

### Complexity

When it comes to routing, the solution offered by EmberJs is far more powerful
than the solution provided by AngularJs.
This comes at the expense of complexity -
grokking EmberJs' router and route objects can be extremely exasperating
for those just starting out,
and a lot of that stems from not yet being familiar with the naming system.
Once past that hurdle, there is yet more additional complexity inherent in
understanding hierarchical state machines and applying that
when designing the structure of the routes (and therefore the rest of the application).

AngularJs, on the other hand, provides a much simpler and easier means
to define routing for the application.
If the application does not require all that added complexity,
such as hierarchical views,
then this offers a much better output for effort proposition.

### Opinionation

Another difference in the routing serves to illustrate
the degree of opinionation in each of the frameworks.

In AngularJs, the router defines each of its routes inline,
and these routes typically do **not** retrieve the model for the controller.
As a result, you see AngularJs developers doing it both ways:
Some elect to use the
[route object's resolve hook](https://docs.angularjs.org/api/ngRoute/provider/$routeProvider),
whereas others simply defer this to the controllers.

In EmberJs, however, you are *almost* forced to retrieve the model for the controller *within the route objects*,
before control is handed over to the controller.
(*Almost* because there are ways to work around this).
