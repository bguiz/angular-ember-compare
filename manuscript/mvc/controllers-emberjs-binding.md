## Two-way binding in EmberJs

Syntax:

```handlebars
<div>
    <button {{action 'someAction'}}>Exclaim harder</button>
    <p>{{someProperty}}</p>
    {{input type="text' value=someProperty}}
</div>
```

Two-way binding in EmberJs works in a very similar fashion to
the way it works in AngularJs -
so we will only cover the differences.

The contents of the `<p>` tag get bound and behave as expected.
However, element attributes are problematic -
we cannot bind any model values to DOM element attributes
using the usual squiggly bracket syntax.
The reason for this is that EmberJs inserts `<script>` tags -
one before and one after -
each bound section of the template;
and of while this works well outside of elements,
it does not work too well for attributes.

We need to use the [`{{bind-attr}}` Handlebars helper](http://emberjs.com/guides/templates/binding-element-attributes/)
instead.
As this is a very common use case for `<input>` tags,
there is an `{{input}}` Handlebars helper that does this for us.

The implication of this is that getting two-way binding to work in EmberJs
can be more complicated, as there is more syntax to learn.
