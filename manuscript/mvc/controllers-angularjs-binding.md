## Two-way binding in AngularJs

Syntax:

```html
<div ng-controller="FooCtrl">
    <button ng-click="someAction()">Press me</button>
    <p>{{someProperty}}</p>
    <input type="text" value="{{someProperty}}">
</div>
```

The template does not do very much.
However, it does provide two different ways to modify the same property on the controller's `$scope`,
and thus it serves to succinctly demonstrate two-way binding.

### View to Model

When the button is clicked, the controller modifies the model.
The template contains a `<p>` tag whose contents are bound to the model,
and the view listens for the change on the model and updates its contents.
The template also contains another binding to the same model,
in the `<input>` tag's `value` attribute,
and this is also updated, in a similar manner.
Both of these sequences are one way bindings, from model to view.

### Model to View

Now, instead of modifying the model, we modify the view instead,
by typing into the input field.
The model listens for the change in the view,
and when the input field is modified,
it detects a change and updates the model.
The `<p>` tag, of course, is still bound to the model,
and the view listens for a change on the model,
and updates its contents, as it did before.

### Behind the Scenes

This is two-way binding in action,
with the first sequence from view to model,
and the second sequence from model back to view.

This magic that happens behind the scenes does **come at a cost** though.
As applications become more complex, it becomes more important to know
how two-way binding works.

The canonical use case for when this becomes especially important
occurs when you have extremely large or complex properties on the `$scope` -
too complex for it to be included in the dirty checking
which gets performed in each digest cycle.
So instead of storing these properties on the `$scope`,
we store them outside of it,
and then manually notify the controller whenever the property has been updated.
This is accomplished through [`$watch`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$watch) and `$apply`,
and using them correctly is contingent upon understanding
how two-way binding works, and how it works together with the digest cycle.

These techniques, however, are beyond the scope of this comparison.
I would suggest this article [on performance tuning](http://tech.small-improvements.com/2013/09/10/angularjs-performance-with-large-lists/)
as further reading on this technique, and several others.
