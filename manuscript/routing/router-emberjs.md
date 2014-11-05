## Routing in EmberJs

![Routing in EmberJs](/images/emberjs-routing.png)

The EmberJs router, and its associated routing concepts,
are significantly more complex than those of AngularJs:

- Supports hierarchical routing, using a hierarchical state machine
- Need to learning naming conventions
- Split of routing responsibility between `Router` and `Route` objects

This added complexity makes for a steeper learning curve at first,
but pays off afterwards, as it supports a richer set of features.

Syntax:

```javascript
App.Router.map(function() {
    this.resource('foos', function() {
        this.route('foo', { path: '/:foo_id' });
    });
    this.route('bar');
});
```

You might be wondering, but where are the controllers, views, and models named?
To make sense of the syntax for the router,
it is first necessary to understand EmberJs' philosophy on
[convention over configuration](http://en.wikipedia.org/wiki/Convention_over_configuration) -
and in particular, its naming conventions.
