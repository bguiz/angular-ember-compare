### Considerations for Designers

Developing a web application using a SPA framework requires skills in both
JavaScript programming and HTML + CSS design.
Sometimes, these are the same person, but quite often, they are not,
and people with different skill sets do need to collaborate.

Templates are where most of the overlap is, and thus where the collaboration,
between programmers and designers needs to occur.

In an AngularJs application, the framework lets you put as much logic as you put your
logic right into the template.
In an EmberJs application, the templating engine, Handlebars,
does not allow you to put any logic into the templates,
and you are forced to extract this into the JavaScript code.

Thus with EmberJs, the decision about where the separation occurs
has already been made.
However, with AngularJs, the decision on where to to draw the line
is left up to the programmers and designers to work out themselves.
