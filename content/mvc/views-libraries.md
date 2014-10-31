### Additional Libraries

AngularJs has got a solid templating engine going for it,
and thus there is no need to use any additional libraries for rendering.

EmberJs with Handlebars, on the other hand,
has an offering that has several drawbacks,
and naturally, some have tried to write their own.

The most promising amongst them is a new library,
[HTMLbars](https://github.com/tildeio/htmlbars),
which solves many of the problems mentioned above:
It is DOM-aware, supports expressions, supports piping,
and does all this without cluttering the DOM with `<script>` tags.

[wycats on how HTMLbars improves on handlebars](http://gist.github.com/wycats/8116673)
[ebryn - HTMLbars is a DOM-aware handlebars](http://talks.erikbryn.com/htmlbars/#/6)

Unfortunately, HTMLBars is not yet ready,
and we still have to use Handlebars for now.

### Discussion

In both AngularJs and EmberJs,
the developer only touches views on the odd occasion.
This is because both frameworks have such powerful view classes built in.

Most of the view logic is encapsulated within templates,
and this is where developers will spend most of their time.
Interestingly, this is also the area where programmers and designers will
require the most collaboration.

AngularJs and EmberJs take very different approaches towards templating,
with the former using DOM-based templating,
and the latter using string-based templating;
and thus having a number of big limitations.

We have looked at both the *M* and the *V* in MVC,
and next we will take a look at controllers,
the things that bind the models and the views together.
