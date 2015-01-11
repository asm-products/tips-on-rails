# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.tipsonrails.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/tips'
  #
  add tips_path, :priority => 0.7, :changefreq => 'daily'
  add help_path, :priority => 0.7, :changefreq => 'daily'
  add about_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
    Tip.find_each do |tip|
      add tip_path(tip), :lastmod => tip.updated_at
    end
end
