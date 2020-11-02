#!/usr/bin/ruby

# Copyright (c) 2008-2014 David Moreno <david@axiombox.com>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "rubygems"
require "nokogiri"
require "open-uri"
require "open_uri_redirections"
require "net/http"
require "feed_validator"

class Feedbag

  CONTENT_TYPES = [
    'application/x.atom+xml',
    'application/atom+xml',
    'application/xml',
    'text/xml',
    'application/rss+xml',
    'application/rdf+xml',
  ].freeze

  def initialize
    @feeds = []
  end

  def self.feed?(url)
    new.feed?(url)
  end

  def self.find(url)
    new.find(url)
  end

  def self.parse_html(raw_html, original_url)
    new.parse_html(raw_html, original_url)
  end

  def feed?(url)
    validator = W3C::FeedValidator.new
    validator.validate_url(url)
    validator.valid?
  end

  def looks_like_feed?(url)
    url =~ /(\.(rdf|xml|rss)$|feed=(rss|atom)|(atom|feed)\/?$)/i
  end

  def find(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    parse_html(open(url, allow_redirections: :all).read, url)
  end

  def parse_html(raw_html, original_url)
    doc = Nokogiri::HTML(raw_html)
    @original_url = original_url
    @original_url = "http://#{@original_url}" if URI.parse(@original_url).scheme.nil?

    if doc.at("base") && doc.at("base")["href"]
      @base_uri = doc.at("base")["href"]
    else
      @base_uri = nil
    end

    (doc/"atom:link").each do |l|
      next unless l["rel"]
      if l["type"] and CONTENT_TYPES.include?(l["type"].downcase.strip) and l["rel"].downcase == "self"
        add_feed(l["href"])
      end
    end

    (doc/"link").each do |l|
      next unless l["rel"]
      if l["type"] and CONTENT_TYPES.include?(l["type"].downcase.strip) and (l["rel"].downcase =~ /alternate/i or l["rel"] == "service.feed")
        add_feed(l["href"])
      end
    end

    (doc/"a").each do |a|
      next unless a["href"]
      if self.looks_like_feed?(a["href"]) and (a["href"] =~ /\// or a["href"] =~ /#{url_uri.host}/)
        add_feed(a["href"])
      end
    end

    (doc/"a").each do |a|
      next unless a["href"]
      if self.looks_like_feed?(a["href"])
        add_feed(a["href"])
      end
    end

    @feeds
  end

private

  def add_feed(feed_url)
    url = feed_url.sub(/^feed:/, '').strip

    if @base_uri
      url = URI.parse(@base_uri).merge(feed_url).to_s
    end

    if !URI.parse(url).absolute?
      orig_url = URI.parse(@original_url)
      url = orig_url.merge(url).to_s
    end

    @feeds.push(url) unless @feeds.include?(url)
  end
end