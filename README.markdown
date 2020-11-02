Feedbag
=======

Feedbag is Ruby's favorite auto-discovery tool/library!

### Quick synopsis

    >> require "feedbag"
    => true
    >> Feedbag.parse_html open("damog.net/blog").read
    => ["http://damog.net/blog/index.rss", "http://damog.net/blog/tags/feed", "http://damog.net/blog/tags/rfeed"]
    >> Feedbag.find "damog.net/blog"
    => ["http://damog.net/blog/index.rss", "http://damog.net/blog/tags/feed", "http://damog.net/blog/tags/rfeed"]
    >> Feedbag.feed? "perl.org"
    => false
    >> Feedbag.feed?("http://jobs.perl.org/rss/standard.rss")
    => true

### Installation

    $ gem install feedbag

### Why should you use it?

- Because it only uses [Nokogiri](http://nokogiri.org/) as dependency.
- Because it follows modern feed filename conventions (like those ones used by WordPress blogs, or Blogger, etc).
- Because it's a single file you can embed easily in your application.
- Because it's faster than rfeedfinder.

### Authors

- [David Moreno](http://damog.net/) <[david@axiombox.com](mailto:david@axiombox.com)>
- [Sergey Goncharov](https://twitter.com/SergeyGoncharov) <[gonch.sergey@gmail.com](mailto:gonch.sergey@gmail.com)>

### Copyright

This is free software. See [COPYING](https://raw.githubusercontent.com/damog/feedbag/master/COPYING) for more information.
