### Views

So if templates handle all the rendering, what is left for the view to do?

As it turns out, in both AngularJs and EmberJs,
the developer will rarely ever have to touch the views.
This is because they are "batteries included",
taking care of most of the heavy lifting for us:

- Deciding when to render the templates
- Two-way binding
- Event handling/ proxying/ bubbling

However, the developer will have to use views when they are doing something
more advanced, such as:

- Integrating with a 3rd party library that does not provide a AngularJs or EmberJs wrapper
- Do something specific upon completion of rendering
- Inheriting or using mixins to share code between several views or other classes

We shall take a brief look at views, and then focus on templates.

### Views in AngularJs

In AngularJs, you never see any JavaScript for views.
Instead, you simply invoke the `ngView` directive in the template.
Any custom view logic must be implemented in the controller in charge of it.

### Views in EmberJs

In EmberJs, you may customise a view in JavaScript.
As mentioned above, one reason we would want to do this is to
integrate with the 3rd party library that does not necessarily understand Ember.

        var myFooView = Ember.View.extend({
            didInsertElement: function() {
                this._super.apply(this, arguments);
                var svg = this.$('svg').get()[0];
                d3.select(svg); //do something with d3 and the <svg> element
            }
        });

Here, we have overridden the `didInsertElement` function on the view,
since it gets triggered after the view has rendered its contents,
and told it to trigger some manipulation of an element within it
once this has happened.

Doing this elsewhere would not have worked,
because `d3` does not understand when it should (or should not) perform its
actions, since it is not aware of EmberJs.

### Back to Templates

Templates are where most of the presentation logic occurs.
Templates in AngularJs and EmberJs can look very similar -
they are both HTML, with the dynamic parts escaped using double squiggly brackets. <super>\*</super>

However, that is a superficial similarity -
the underlying approach taken by each is fundamentally different.

&nbsp;&nbsp;<super>\*</super> With AngularJs, in addition to this,
some dynamic input may be identified by `ng-`\* attributes,
and any custom designed directives added by the developer.
