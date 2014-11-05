## Controllers in EmberJs

![Controllers in EmberJs](/images/emberjs-controller.png)

EmberJs controllers conform to the pure MVC definition of them.

Syntax:

```javascript
App.FooController = Ember.Controller.extend({
    someProperty: 'More exclamation marks',
    actions: {
        someAction: function() {
            this.set('someProperty', this.get('someProperty') + '!');
        }
    }
});
```

EmberJs enforces a clean separation between properties and actions
within a controller -
all actions are grouped into a single hash.

Another things worth pointing out here,
is that unlike AngularJs,
EmberJs distinguishes between properties set on the controller,
and models used by the controller.
Models are typically created and passed into a controller,
by a `Ember.Route` object,
which we shall take a look at when we look at
[routing](/routing/routes-emberjs.html).
This is because there is only one instance of any controller instantiated,
and thus its state does *not* get reset each time.
This is can be confusing when working with EmberJs for the first time.

Another thing worth noting is that we had to name this controller `FooController`.
In AngularJs, we were free to name our controller anything we wished to -
`BarCtrl` would have worked just as well as `FooCtrl`.
In EmberJs, however, we must take care to name our controllers -
and most other types of objects -
according to the specified naming convention.

This is a common **beginner's gotcha**, and takes some getting used to.
Until then, do not hesitate to refer to the handy tables,
in the [naming conventions guide](http://emberjs.com/guides/concepts/naming-conventions/)
as a reference.
A completely customised naming strategy is also possible,
by extending (or replacing) EmberJs' [default resolver](http://emberjs.com/api/classes/Ember.DefaultResolver.html).
However, this is often more effort than it is worth,
and most developers will choose to stick to the default resolver.
