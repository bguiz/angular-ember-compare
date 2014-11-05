### Hash Fragments

Hash fragments have been around since the early days of the Internet,
pre-dating single-page applications, and even JavaScript!

Their usage was very simple though.
When you had a web page that was rather long, and you wished to link to a different
section on the same page, rather than to a different page,
you would do something like this, in your HTML:

```html
<a href="#partOfPageManyScrollsAway">
    Clicking here will jump to a part of the page that is many scrolls away
</a>
```

&hellip; and somewhere else *in the same document*, we will have:

```html
<a name="partOfPageManyScrollsAway">
    You sure got here quickly!
</a>
```

As you may have guessed, clicking on the first `<a>` tag
scrolls the second `<a>` tag into view in the browser.

&hellip; but that is not all!
If you look in the address bar, you will find that the URL has been suffixed with
`#partOfPageManyScrollsAway`.
When you click on the back button,
you go back to where you were originally within the page - the first `<a>` tag
When you click the forward button now,
you go back to the second `<a>` tag again.

You can try this out for yourself!
Go to any article on [Wikipedia](http://en.wikipedia.org)
and find citations in line with the text.
Many of these are hyperlinks to other `<a>` tags
that are at the bottom of the page, in the list of citations.
Click on a few of these in a row, and then use the back and forward buttons.

This was the only way (until recently),
where the browser's URL could change without navigating to a different page,
**and** forward and back buttons continue working,
meaning that browser history was preserved.

Given this, the developers of SPA frameworks decided to use this as the means
to store the URL of SPA's current route.
That is, as far as the SPA was concerned,
its own internal URL **was the hash fragment**.
Thus, instead of using words and numbers in hash fragments,
they simply used the URL path instead.
For example: `#/foo/123` or `#/bar/123/edit`
