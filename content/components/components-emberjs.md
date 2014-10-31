### Components in EmberJs

![Components in EmberJs](/img/emberjs-component.png)

The bare minimum syntax for an EmberJs component would be to simply create a template,
according to the naming conventions:

        {{!-- components/the-foo --}}
        <div>
            <p>The Foo</p>
        </div>

The naming convention is that they be prefixed with `components/`,
and the name must contain at least one hyphen (`-`).

In the DOM, we use a Handlebars helper with the same name as the component:

        {{the-foo}}

All this does however, is render one template within another -not very useful!
We want to be able to do the same three things that we did with the AngularJs directive:

- Use elements to represent the component in the DOM (element restriction)
- Display content from the outer template within the component (transclusion)
- Pass in select models or attributes from the outer template to the component (scope and scope isolation)

This is quite easily achieved:

        {{!-- components/the-foo --}}
        <div>
            <p>The Foo. Bar is: {{foo.bar}}</p>
            {{yield}}
        </div>

&hellip; and in the DOM:

        {{#the-foo foo=model}}
            <p>Some text included from outside the component</p>
        {{/the-foo}}

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

        App.TheFooComponent = Ember.Component.extend({
            attributeBindings: ['foo']
        });

We create an object that extends `Ember.Component`,
according to the naming conventions,
and define which properties should be bound by the component
using the `attributeBindings` property.

All in all, extremely straight forward,
the trickiest part is getting the naming conventions right!
The [documentation for `Ember.Component`](http://emberjs.com/api/classes/Ember.Component.html)
is a good reference.

### Discussion

In comparing the various aspects of these two SPA frameworks so far,
in every single point of comparison,
EmberJs' offering has been significantly more complicated -
and harder to learn - than its AngularJs counterpart.
With components, however, the opposite is true,
with the learning curve for creating custom components in AngularJs
being far steeper than for creating custom components in EmberJs.
This is because AngularJs' offering is low-level, and more flexible.
In EmberJs, most decision have been made for you -
they can be thought of as
["element-restricted, isolate-scoped, transcluded directives"](http://docs.google.com/presentation/d/1e0z1pT9JuEh8G5DOtib6XFDHK0GUFtrZrU3IfxJynaA/present?slide=id.g177e4bd2b_0400).

While AngularJs does not provide a *component* per se,
it does provide a means to create them by combining a number of lower level concepts,
on AngularJs directives.
By combining them together in a certain pattern,
one can create components.
However, the developer is also free to do something else entirely,
and combine them in a different way, or treat some as optional,
and this flexibility allows for more specific needs to be catered to.

EmberJs components, on the other hand,
provide something very close to the web components specification out of the box,
and the developer merely has to extend `Ember.Component`
to get all this functionality.

Both AngularJs and EmberJs have plans to make their frameworks support the
web components specifications, when it comes out of draft status.
Miško Hevery has written about plans to [make web components work seamlessly with AngularJs directives](https://groups.google.com/forum/#!msg/polymer-dev/4RSYaKmbtEk/uYnY3900wpIJ).
Yehuda Katz, [describes plans for Web Components in EmberJs](https://gist.github.com/wycats/9144666b0c606d1838be),
and a concrete plan for "how Ember could adopt semantics similar to web components."

Knowing that both frameworks are aligned with the specifications is good,
because applications that are developed with these frameworks will themselves
will already be largely compliant with these standards,
and gain the benefits from inherent from being so,
such as future cross-browser support and portability.
