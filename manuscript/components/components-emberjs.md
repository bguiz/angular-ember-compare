## Components in EmberJs

![Components in EmberJs](/images/emberjs-component.png)

The bare minimum syntax for an EmberJs component would be to simply create a template,
according to the naming conventions:

```handlebars
{{!-- components/the-foo --}}
<div>
    <p>The Foo</p>
</div>
```

The naming convention is that they be prefixed with `components/`,
and the name must contain at least one hyphen (`-`).

In the DOM, we use a Handlebars helper with the same name as the component:

```handlebars
{{the-foo}}
```

All this does however, is render one template within another - not very useful!
We want to be able to do the same three things that we did with the AngularJs directive:

- Use elements to represent the component in the DOM (element restriction)
- Display content from the outer template within the component (transclusion)
- Pass in select models or attributes from the outer template to the component (scope and scope isolation)

This is quite easily achieved:

```handlebars
{{!-- components/the-foo --}}
<div>
    <p>The Foo. Bar is: {{foo.bar}}</p>
    {{yield}}
</div>
```

&hellip; and in the DOM:

```handlebars
{{#the-foo foo=model}}
    <p>Some text included from outside the component</p>
{{/the-foo}}
```

In EmberJs, we use a string-based templating language, Handlebars,
as opposed to a DOM-based templating language.
Thus, we will not ever write, in the DOM,
tags names that match the custom component names;
instead we use Handlebars helpers, in this case `{{the-foo}}`.

We display content from the outer template within the component,
simply by using the `{{yield}}` Handlebars helper.

We pass in select attributes from the outer template into the component by
defining those attributes within the Handlebars helper invoking the component.
This is the only part which requires some custom code.

```javascript
App.TheFooComponent = Ember.Component.extend({
    attributeBindings: ['foo']
});
```

We create an object that extends `Ember.Component`,
according to the naming conventions,
and define which properties should be bound by the component
using the `attributeBindings` property.

All in all, extremely straight forward,
the trickiest part is getting the naming conventions right!
The [documentation for `Ember.Component`](http://emberjs.com/api/classes/Ember.Component.html)
is a good reference.
