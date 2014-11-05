## How this might change with ES6

There is currently [a draft proposal in ECMAScript 6](http://wiki.ecmascript.org/doku.php?id=harmony:observe),
the standards specification for the next version of JavaScript,
for `Object.observe()`.
This specification calls for native methods on all POJSOs
that may be used to observe for changes made to object state.

This ability will turn the issue of wrapper objects with accessors versus
dirty checking on its head,
as **both of them will no longer be necessary** to listen for changes in models,
and to accomplish data-binding between models and views.
[This article](http://bocoup.com/weblog/javascript-object-observe/) even goes as far as to say

> "Everything you think you know about data binding — and every trick MVC libraries are using to pull it off — is about to be flipped on its head".

It is pertinent to remember, that while some browsers, as well as NodeJs,
have already implemented `Object.observe()`,
it is still under discussion, and is still **presently a proposal**.
So actual implementation can and will vary;
and adoption across all devices, is still relatively unknown.
