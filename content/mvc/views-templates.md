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

