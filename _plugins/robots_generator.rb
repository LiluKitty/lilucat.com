module Jekyll
  class RobotsGenerator < Generator
    safe true
    priority :low

    def generate(site)
      robots_content = generate_robots_content(site)
      
      site.pages << RobotsPage.new(site, robots_content)
    end

    private

    def generate_robots_content(site)
      config = site.config['robots'] || {}
      
      content = []
      
      # Add sitemap URL
      sitemap_url = config['sitemap_url'] || "#{site.config['url']}/sitemap.xml"
      content << "Sitemap: #{sitemap_url}"
      content << ""
      
      # Add user agent rules
      user_agents = config['user_agents'] || ['*']
      
      user_agents.each do |user_agent|
        content << "User-agent: #{user_agent}"
        
        # Add allow rules
        allows = config['allows'] || ['/']
        allows.each do |allow|
          content << "Allow: #{allow}"
        end
        
        # Add disallow rules
        disallows = config['disallows'] || []
        disallows.each do |disallow|
          content << "Disallow: #{disallow}"
        end
        
        content << ""
      end
      
      # Add crawl delay if specified
      if config['crawl_delay']
        content << "Crawl-delay: #{config['crawl_delay']}"
        content << ""
      end
      
      content.join("\n")
    end
  end

  class RobotsPage < Page
    def initialize(site, content)
      @site = site
      @base = site.source
      @dir = '/'
      @name = 'robots.txt'

      self.process(@name)
      self.data = {}
      self.content = content
    end

    def read_yaml(base, name, opts = {})
      # Don't read the YAML front matter even if it exists.
    end
  end
end 