## Views and Templates

Models, views, and controllers are the *M*, *V* and *C* of MVC,
and most SPA frameworks use these concepts to help developers structure
and organise their code.

### Templates

However, almost all of them include one more feature in the same vein:
the template.
Templating, strictly speaking, is one of the responsibilities of a view in MVC,
however, they are large and complex enough to warrant a discussion on their own.
This is because all web apps - both traditional and single page -
ultimately need to render HTML, which is a document format.

Templates are essentially files with special syntax that allow the developer
to specify the logic with which to render the HTML.
This template typically has two inputs, one static, and the other dynamic.
The static inputs to the template are the bits that render HTML without any
change in between no matter the context.
The dynamic inputs to the template are the bits that render HTML differently
based on context.

In both AngularJs and EmberJs, the static inputs are pure HTML -
write them as you would a regular HTML document.
Similarly, in both frameworks, the dynamic inputs are identified as any parts
in between `{{` and `}}` (double squiggly brackets). <super>&lowast;</super>

<super>&lowast;</super> With AngularJs, in addition to this,
some dynamic input may be identified by `ng-*` attributes,
and any custom designed directives added by the developer.

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

In AngularJs, you never see any Javascript for views.
Instead, you simply invoke the `ngView` directive in the template.
Any custom view logic must be implemented in the controller in charge of it.

### Views in EmberJs

In EmberJs, you may customise a view in Javascript.
As mentioned above, one reason we would want to do this is to
integrate with the 3rd party libary that does not necessarily understand Ember.

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
they are both HTML, with the dynamic parts escaped using double squiggly brackets. <super>&lowast;</super>

However, that is a superficial similarity -
the underlying approach taken by each is fundamentally different.

<super>&lowast;</super> With AngularJs, in addition to this,
some dynamic input may be identified by `ng-*` attributes,
and any custom designed directives added by the developer.

### Templates in AngularJs

Syntax:

        <body ng-controller="FooController">
            <input ng-model="foo" value="bar">
            <button ng-click="changeFoo()">{{buttonText}}</button>
        </body>

AngularJs uses a DOM-based templating mechanism.
This means that the templates are the rendered HTML.
When the app runs, the elements are rendered with
the original contents of the template.
Subsequently, AngularJs kicks in, and traverse the entire DOM tree,
inspecting for special decorations,
and then modifies the DOM according to the desired behaviour.
In fact, if you are quick - or set some break points -
you will notice a flicker between the two.

The special decorations that it looks out for are:

- Directives
    - Elements or attributes that link to modules known to AngularJs
    - AngularJs comes with several built indirectives,
      and all of them are prefixed with `ng-*`
    - THe developer may also define his own custom directives
- Markup
    - Any part of the markup whcih appears between double squiggly braces,
      `{{like this}}`
    - AngularJs evaluates the expression within these braces,
      and substitutes it for the result

AngularJs allows for an extremely expressive syntax to be added to the
expressions within the templates,
including Javascript expression,
and filters using a UNIX-style pipe (`|`) syntax.

### Templates in EmberJs

Syntax:

        {{input type='text value=model.foo'}}
        <button {{action 'changeText'}}>{{model.buttonText}}</button>

Ember uses a templating language, [Handlebars](http://handlebarsjs.com/).
Its approach is fundamentally different to that of AngularJs',
as it uses a string-based templating mechanism,
as opposed to a DOM-based templating mechanism.
This means that it parses the entire tempalte beforehand,
and generates a series of functions that contain
the static inputs to the templates inline,
and accept parameters for the dynamic inputs to the templates.

That explanation would be awfully hard to follow without context -
so here is the compiled function that EmberJs + Handlebars would geenrate
for the template sepcified above.

        function anonymous(Handlebars,depth0,helpers,partials,data) {
          this.compilerInfo = [4,'>= 1.0.0'];
          helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
          var buffer = '', stack1, hashContexts, hashTypes, options, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression;
          hashContexts = {'type': depth0};
          hashTypes = {'type': "STRING"};
          options = {hash:{
            'type': ("text value=model.foo")
          },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data};
          data.buffer.push(escapeExpression(((stack1 = helpers.input || depth0.input),stack1 ? stack1.call(depth0, options) : helperMissing.call(depth0, "input", options))));
          data.buffer.push("\n<button ");
          hashTypes = {};
          hashContexts = {};
          data.buffer.push(escapeExpression(helpers.action.call(depth0, "changeText", {hash:{},contexts:[depth0],types:["STRING"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
          data.buffer.push(">");
          hashTypes = {};
          hashContexts = {};
          data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "model.buttonText", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
          data.buffer.push("</button>\n");
          return buffer;
        }

Do not worry if that looks like gibberish to you -
simply look how it alternatiely does `data.buffer.push("some string");`
and `data.buffer.push(/* some expression */);`.
Those are the static and dynamic inputs respectively.
Ultimately, this function builds a string,
and that string is added to the rendered DOM.

The difference between DOM-based templating mechanisms
and string-based templating mechanisms may be thought of as
an outside-in approach versus an inside-out approach.

The string-based templating mechanism has some pros and cons:

- Pros:
    - Since templates are pre-compiled they render quickly
    - No flickering on screen as first render is already populated
      with the dynamic values
- Cons:
    - Requires an extra compilation step
    - In order for two-way bindings to work,
      [additional DOM nodes need to be inserted](http://emberjs.com/guides/understanding-ember/keeping-templates-up-to-date/) - etamorph `<script>` tags in this case

All of these are pretty minor considerations,\
except for additional DOM nodes being inserted.
Litering the DOM with numerous `<script>` tags makes it quite cluttered and ugly,
and makes inspecting it less fun.
It makes one wonder, surely, there must be a better way to do this!

The other implication of this is that two-way binding to *attributes*
is simply not possible, using this syntax.
Ember gets around this by defining a special alternative syntax, `{{bind-attr}}`.
All this put together makes it feel more like something tacked together,
rather than a well engineered, elegant, solution.

Separately, the syntax allowed for expression within Handlebars templates
is quite restrictive.
Properties may only be looked up and output as-is.
If any processing or formatting is required,
the only way to do this is by defining properties on a controller,
or by [registering Handlebars helper functions](http://emberjs.com/guides/templates/writing-helpers/).

### Considerations for Designers

Developing a web app using a SPA framework requires skills in both
Javascript programming and HTML + CSS design.
Sometimes, these are the same person, but quite often, they are not,
and peopel with different skill sets do need to collaborate.

Templates are where most of the overlap is, and thus where the collaboration,
between programers and designers needs to occur.

In an AngularJs app, the framework lets you put as much logic as you put your
logic right into the template.
In an EmberJs app, the templating engine, Handlebars,
does not allow you to put any logic into the templates,
and you are forced to extract this into the Javascript code.

Thus with EmberJs, the decision about where the separation occurs
has already been made.
However, with AngularJs, the decision on where to to draw the line
is left up to the programmers and designers to work out themselves.

### Additonal Libraries

AngularJs has got a solid templating engine going for it,
and thus there is no need to use any addtional libraries for rendering.

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
with the former using DOM-based temaplting,
and the latter using string-based templating;
and thus having a number of big limitations.

We have looked at both the *M* and the *V* in MVC,
and next we will take a look at controllers,
the things that bind the models and the views together.
