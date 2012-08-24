# jquery.expand assets

A Sprockets processor that wraps html in a jquery.expand function. It is specifically meant to work within the Rails asset pipeline.

The processor outputs CoffeeScript, so you'll need to have the result be processed by the CoffeeScript processor.

## Creating and using templates

Create your templates in a directory named `app/assets/javascripts/templates`. Organize your templats within subdirectories. I personally organize them based on what resource they're associated with.

Write your template and wrap it in a root element.

Example: `app/assets/javascripts/templates/articles/_entry.js.coffee.expand`
    <div>
      <h2 class='name'></h2>
      <p class='content'></p>
    </div>

Your template is now available to Javascript as a function on the `JST` object. Pass an expand directive to the function and you'll be given the result minus the wrapper element.

Example: see `articles/_entry.js.coffee.expand` above
    directive = { name: 'Joe', content: 'I love Smurfs.' }
    html = JST['articles/entry'](directive)
    $('body').append(html)

In this example, the result html will be:
    <h2 class='name'>Joe<h2>
    <p class='content'>I love Smurfs.</p>

## Naming conventions

Templates are named on the `JST` object based on their filename. Directories under `app/assets/javascripts/templates` are preserved. If the template's filename starts with an underscore, the underscore is removed from the name.

Examples:

`articles/_entry.js.coffee.expand` becomes `articles/entry`  
`articles/comments/_comment.js.coffee.expand` becomes `articles/comments/comment`  
`articles/response.js.coffee.expand` becomes `articles/response`  

## Resources

* [jquery.expand](https://github.com/atomicobject/jquery.expand)
* [jquery.expand examples](http://spin.atomicobject.com/2011/07/10/jquery-expand-examples/)

## Thanks so much!

I'd like to give a huge 'thank you' to the [Sprockets](https://github.com/sstephenson/sprockets), [haml_assets](https://github.com/infbio/haml_assets), and [haml_coffee_assets](https://github.com/netzpirat/haml_coffee_assets) projects. Without their examples, I'm not sure I would have figured out the code required to create the Rails engine and Tilt template.

Authors
=======
* Matt Fletcher (fletcher@atomicobject.com)
* © 2012 [Atomic Object](http://www.atomicobject.com/)
* More Atomic Object [open source](http://www.atomicobject.com/pages/Software+Commons) projects
