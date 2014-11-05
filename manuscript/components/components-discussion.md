## Discussion

In comparing the various aspects of these two SPA frameworks so far,
in every single point of comparison,
EmberJs' offering has been significantly more complicated -
and harder to learn - than its AngularJs counterpart.
Components, however, are the odd one out, where the opposite is true.

This is because AngularJs' offering is low-level, and more flexible.
In EmberJs, most decisions have been made for you -
they can be thought of as
["element-restricted, isolate-scoped, transcluded directives"](http://docs.google.com/presentation/d/1e0z1pT9JuEh8G5DOtib6XFDHK0GUFtrZrU3IfxJynaA/present?slide=id.g177e4bd2b_0400).

While AngularJs does not provide a *component* per se,
it does provide a means to create them by combining a number of lower level concepts
(restrict, transclude and isolate scope) with directives.
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
and gain the benefits inherent from being so,
such as future cross-browser support and portability.
