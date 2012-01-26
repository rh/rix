# rix: command-line XML editing and refactoring

rix makes it very easy to edit multiple XML files at once. You can use XPath to select just the nodes you want to edit, and supply a list of files to work on. With rix you can:

* set the value of elements and attributes
* add elements and attributes
* remove elements and attributes
* rename elements and attributes
* trim elements and attributes
* count elements and attributes
* pretty print elements and attributes

## Installation

    gem install rix

## Basic usage

To see a list of available commands, run:

    $ rix help commands

This will currently output the following:

    Available commands:
      add-element
      add-attribute
      set
      remove
      rename
      trim
      count
      show
      help

To set the value of all `date` elements:

    $ rix set --value 26-01-2012 //date *.xml

When using `set`, values can be cleared by omitting the `value` option:

    $ rix set //@secret *.xml

To add a new `td` element to every `tr` element in all HTML files in the current directory, run:

    $ rix add-element --name td //tr *.html

To add a `@foo` attribute with the value 'bar' to every element in every XML file in the current directory, run:

    $ rix add-attribute --name foo --value bar "//*" *.xml

To remove all `font` elements from all HTML files in the current directory and below, run:

    $ rix remove //font **/*.html

The `rename` command renames all selected elements and attributes.

    $ rix rename //h2 index.html --name h1

The values of elements and attributes can be trimmed, so ' foo ' becomes 'foo'. Trimming all text nodes is as easy as:

    $ rix trim "//text()" *.xml

Two commands are useful when run before an editing command: `count` and `show`.
The `count` command gives the number of selected nodes (elements, attributes etc.) for every file. For example:

    $ rix count //p *.html

might give an output such as this:

    public/404.html: 2
    public/422.html: 1
    public/500.html: 3

`show` gives a pretty-printed output of all selected nodes:

    $ rix show //ul index.html

will result in something like this:

    <ul id="menu">
      <li><a href="/">Home</a></li>
      <li><a href="/news">News</a></li>
      <li><a href="/jobs">Jobs</a></li>
      <li><a href="/about">About</a></li>
    </ul>

