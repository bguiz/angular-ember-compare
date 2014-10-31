## Components

![Components in SPAs](/img/spa-component.png)

Browsers used to display documents -
that is content that had text formatting and images.
Web pages used to be simply what you could create using a word processor,
or see printed on a newspaper,
expect that it was delivered over the Internet,
and displayed on a computer screen.
They are much more than that now, however.
Web pages are interactive, and can respond to the user in ways
that a newspaper cannot.
Some are so advanced in these types of interactions that the phrase,
"web page" no longer seems an apt description -
we call them *web applications*, or *web applications*.

The typical thing that we create with AngularJs and EmberJs are most certainly
not web pages any longer,
and fall squarely into the web application category.
That being said, the HTML that we implement our applications in is still very much
designed around syntax used to describe *document*s.
This makes things tricky for the developer,
because over the years, we have created workaround after workaround
to continue making this document-oriented syntax continue working for us.

Thankfully, the standards body that governs HTML recognises this,
and is evolving its specifications to keep up with how HTML is being used.
The [Web Components Specification](http://www.w3.org/TR/components-intro/)
is a draft specification, which describes a way in which we can
create *components* that can be thought of as a building block,
which contains a HTML template, CSS styles, and JavaScript behaviour.

Web components, however, are not yet available -
but both AngularJs and EmberJs provide their own ways to create components
that behave very similarly to web components.
