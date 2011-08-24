# rix: command-line XML editing and refactoring

rix makes it very easy to edit multiple XML files at once. You can use XPath to select just the nodes you want to edit, and supply a list of files to work on. With rix you can:

* add elements
* remove elements and attributes
* rename elements and attributes
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
      remove
      rename
      count
      show
      help

To add a new `td` element to every `tr` element in all HTML files in the current directory, run:

    $ rix add-element --name td //tr *.html

To remove all `font` elements from all HTML files in the current directory and below, run:

    $ rix remove //font **/*.html

The `rename` command renames all selected elements and attributes.

    $ rix rename //h2 index.html --name h1

Two commands are useful when run before an editing command: `count` and `show`.
The `count` command gives the number of selected nodes(elements, attributes etc.) for every file. For example:

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

