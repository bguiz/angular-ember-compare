## Routing in AngularJs

![Routing in AngularJs](/images/angularjs-routing.png)

Setting up a router - the object responsible for providing routing capability -
is extremely easy in AngularJs:

```javascript
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
```

The syntax explains itself (a realiable indicator of great design),
but we shall go through it nonetheless.

AngularJs comes with a built-in module,
[`$routeProvider`](https://docs.angularjs.org/api/ngRoute/provider/$routeProvider),
which is in charge of handling routing functionality within the application.
This module needs to be configured by the developer.

The `$routeProvider` module should be configured before the application is initialised,
and any other code is run, and therefore this needs to be run during the application's
[configuration phase](http://www.angularjshub.com/examples/modules/configurationrunphases/)
of the application's life cycle.

The configuration consists of pairs of routing information,
where each pair consists of a URL path, an an object from which an MVC state can be derived.
These pairs are passed in by calling `.when()` on the `$routeProvider` object.
The first parameter being the URL path, and the second parameter an object,
which should give AngularJs enough information to derive an MVC state.
Typically this would mean pointing to a controller plus a template:
a view is generated from a template,
and the controller knows how to fetch or construct a model.
