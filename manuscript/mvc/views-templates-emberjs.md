## Templates in EmberJs

![Views in EmberJs](/images/emberjs-view.png)

### Syntax

```handlebars
{{input type='text value=model.foo'}}
<button {{action 'changeText'}}>{{model.buttonText}}</button>
```

EmberJs uses a templating language, [Handlebars](http://handlebarsjs.com/).
Its approach is fundamentally different to that of AngularJs',
as it uses a string-based templating mechanism,
as opposed to a DOM-based templating mechanism.
This means that it parses the entire template **beforehand**,
and generates a series of functions that contain
the static inputs to the templates in-line,
and accept parameters for the dynamic inputs to the templates.

That explanation would be awfully hard to follow without context -
so here is the compiled function that EmberJs + Handlebars would generate
for the template specified above.

```javascript
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
```

Do not worry if that looks like gibberish to you -
simply look at how it alternately does `data.buffer.push("some string");`
and `data.buffer.push(/* some expression */);`.
Those are the **static** and **dynamic** inputs respectively.
Ultimately, this function builds a string,
and that string is added to the rendered DOM.

The difference between DOM-based templating mechanisms
and string-based templating mechanisms may be thought of as
an outside-in approach versus an inside-out approach.

### Pros and Cons

The string-based templating mechanism has some pros and cons:

- Pros:
    - Since templates are pre-compiled they render quickly
    - No flickering on screen as first render is already populated
      with the dynamic values
- Cons:
    - Requires an extra compilation step
    - In order for two-way bindings to work,
      [additional DOM nodes need to be inserted](http://emberjs.com/guides/understanding-ember/keeping-templates-up-to-date/) - metamorph `<script>` tags in this case

All of these are pretty minor considerations,
except for additional DOM nodes being inserted.
Littering the DOM with numerous `<script>` tags makes it quite cluttered and ugly,
and makes inspecting it a lot less "fun".
It makes one wonder, surely, there must be a better way to do this!

The other implication of this is that two-way binding to element *attributes*
is simply not possible, using this syntax.
EmberJs gets around this by defining a special alternative syntax, `{{bind-attr}}`.

All this put together makes it feel more like something tacked together,
rather than a well engineered, elegant, solution.

Separately, the syntax allowed for expression within Handlebars templates
is quite restrictive.
Properties may only be looked up and output as-is.
If any processing or formatting is required,
the only way to do this is by defining properties on a controller,
or by [registering Handlebars helper functions](http://emberjs.com/guides/templates/writing-helpers/).
