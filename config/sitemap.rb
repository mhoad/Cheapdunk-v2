require 'rubygems'
require 'sitemap_generator'


SitemapGenerator::Sitemap.default_host = 'http://www.cheapdrunk.com.au'
SitemapGenerator::Sitemap.sitemaps_host = "https://s3.amazonaws.com/cheapdrunk/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  add '/terms', :changefreq => 'monthly'
  Venue.find_each do |venue|
    add venue_path(venue), :lastmod => venue.updated_at
  end
end
#SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task