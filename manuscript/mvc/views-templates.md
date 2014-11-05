## Templates

Almost every SPA framework includes one more feature in the same vein as views: Templates.
Templating, strictly speaking, is one of the responsibilities of a view in MVC,
however, they are large and complex enough to warrant a discussion on their own.
This is because all web applications - both traditional and single page -
ultimately need to render HTML, which is a document format.

Templates are essentially files with special syntax that allow the developer
to specify simple logic with which to render the HTML.
This template typically has two inputs, one static, and the other dynamic.
The static inputs to the template are the bits that render HTML without any
change in between no matter the context.
The dynamic inputs to the template are the bits that render HTML differently
based on context.

### Similarities

In both AngularJs and EmberJs, the static inputs are pure HTML -
write them as you would a regular HTML document.
Similarly, in both frameworks, the dynamic inputs are identified as any parts
in between `{{` and `}}` (double squiggly brackets).
In addition to this, in AngularJs,
some dynamic input may be also be speicifed using `ng-`\* attributes,
and any custom designed directives added by the developer.

Templates in AngularJs and EmberJs can thus look very similar. This, however, is a superficial similarity - the underlying approach taken by each is fundamentally different.

Templates are where most of the presentation logic occurs.

