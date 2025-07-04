# Plugin to generate app-ads.txt automatically
# Place this file in _plugins/ directory

module Jekyll
  class AppAdsGenerator < Generator
    safe true
    priority :low

    def generate(site)
      # Only generate if app_ads config exists
      return unless site.config['app_ads']

      app_ads_config = site.config['app_ads']
      
      # Generate the app-ads.txt content
      content = generate_app_ads_content(app_ads_config)
      
      # Create the file
      site.static_files << AppAdsFile.new(site, content)
    end

    private

    def generate_app_ads_content(config)
      lines = []
      
      # Add Google AdMob entry
      if config['publisher_id'] && config['google_certification']
        lines << "google.com, #{config['publisher_id']}, DIRECT, #{config['google_certification']}"
      end
      
      # Add additional networks if configured
      if config['additional_networks']
        config['additional_networks'].each do |network|
          lines << "#{network['domain']}, #{network['publisher_id']}, #{network['relationship']}, #{network['certification']}"
        end
      end
      
      # Join all lines with newlines
      lines.join("\n")
    end
  end

  class AppAdsFile < StaticFile
    def initialize(site, content)
      @site = site
      @content = content
      @relative_path = 'app-ads.txt'
      @extname = '.txt'
      @name = 'app-ads.txt'
    end

    def write(dest)
      dest_path = destination(dest)
      FileUtils.mkdir_p(File.dirname(dest_path))
      File.write(dest_path, @content)
    end
  end
end 