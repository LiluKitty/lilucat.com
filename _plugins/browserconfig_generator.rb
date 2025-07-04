module Jekyll
  class BrowserconfigGenerator < Generator
    safe true
    priority :low

    def generate(site)
      browserconfig_content = generate_browserconfig_content(site)
      
      site.pages << BrowserconfigPage.new(site, browserconfig_content)
    end

    private

    def generate_browserconfig_content(site)
      config = site.config['browserconfig'] || {}
      
      # Default values
      tile_color = config['tile_color'] || '#da532c'
      square_logo = config['square_logo'] || '/assets/icons/mstile-150x150.png'
      wide_logo = config['wide_logo']
      large_logo = config['large_logo']
      
      content = []
      content << '<?xml version="1.0" encoding="utf-8"?>'
      content << '<browserconfig>'
      content << '    <msapplication>'
      content << '        <tile>'
      content << "            <square150x150logo src=\"#{square_logo}\"/>"
      
      if wide_logo
        content << "            <wide310x150logo src=\"#{wide_logo}\"/>"
      end
      
      if large_logo
        content << "            <square310x310logo src=\"#{large_logo}\"/>"
      end
      
      content << "            <TileColor>#{tile_color}</TileColor>"
      content << '        </tile>'
      content << '    </msapplication>'
      content << '</browserconfig>'
      
      content.join("\n")
    end
  end

  class BrowserconfigPage < Page
    def initialize(site, content)
      @site = site
      @base = site.source
      @dir = '/'
      @name = 'browserconfig.xml'

      self.process(@name)
      self.data = {}
      self.content = content
    end

    def read_yaml(base, name, opts = {})
      # Don't read the YAML front matter even if it exists.
    end
  end
end 