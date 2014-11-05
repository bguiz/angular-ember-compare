## Views in EmberJs

In EmberJs, you may customise a view in JavaScript.
As mentioned above, one reason we would want to do this is to
integrate with a 3rd party library that does not necessarily understand Ember.

```javascript
var myFooView = Ember.View.extend({
    didInsertElement: function() {
        this._super.apply(this, arguments);
        var svg = this.$('svg').get()[0];
        d3.select(svg); //do something with d3 and the <svg> element
    }
});
```
Here, we have overridden the `didInsertElement` function on the view,
since it gets triggered after the view has rendered its contents,
and told it to trigger some manipulation of an element within it
once this has happened.

Doing this elsewhere would not have worked,
because `d3` does not understand **when** it should (or should not) perform its actions within an EmberJs view,
since it is unaware of EmberJs.
