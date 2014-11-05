# Components

![Components in SPAs](/images/spa-component.png)

Browsers used to display documents -
that is content that had formatted and images, and not very much else.
Web pages used to be simply what you could create using a word processor,
or see printed on a newspaper,
except that it was delivered over the Internet,
and displayed on a computer screen.

They are much, much, more than that now!
Web pages are interactive, and can respond to the user in ways
that a newspaper cannot.
Some are so advanced in these types of interactions that the phrase,
"web page" no longer seems an apt name -
we have taking to calling them *web applications*, or *web apps* now.

The typical things that we create using AngularJs and EmberJs are most certainly
not web pages any longer,
and fall squarely into the web application category.
That being said, the HTML that we implement our web applications with
is still very much designed around syntax used to describe *documents*.
This makes things tricky for the developer,
because over the years, we have created workaround atop workaround
to force this document-oriented syntax continue working for us,
when what we are really creating is much closer to
desktop or mobile software user interfaces.

Thankfully, the standards body that governs HTML recognises this,
and is evolving its specifications to keep up with how HTML is being used.
The [Web Components Specification](http://www.w3.org/TR/components-intro/)
is a draft specification, which describes a way in which we can
create *components* that can be thought of as building blocks.
These blocks each contain a HTML template, CSS styles, and JavaScript to describe its behaviour.

Web components, however, are not yet available -
but both AngularJs and EmberJs provide their own ways to create components
that behave similarly to web components.
