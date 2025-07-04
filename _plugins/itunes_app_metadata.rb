require 'net/http'
require 'json'

module Jekyll
  class ItunesAppMetadata < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      ios_apps = site.config['ios_apps'] || {}
      ios_apps.each do |key, app|
        next unless app['url']
        app_id = extract_app_id(app['url'])
        next unless app_id
        metadata = fetch_itunes_metadata(app_id)
        if metadata
          app['name'] = metadata['trackName']
          # app['icon'] = metadata['artworkUrl512'] # Ya no sobrescribir el icono
          app['rating'] = metadata['averageUserRating']
          app['ratings_count'] = metadata['userRatingCount']
        end
      end
    end

    private

    def extract_app_id(url)
      # Busca el id en la url (idXXXXXXXXXX)
      match = url.match(/id(\d+)/)
      match ? match[1] : nil
    end

    def fetch_itunes_metadata(app_id)
      url = URI("https://itunes.apple.com/lookup?id=#{app_id}")
      begin
        response = Net::HTTP.get(url)
        json = JSON.parse(response)
        if json['results'] && json['results'].any?
          return json['results'][0]
        end
      rescue => e
        Jekyll.logger.warn "iTunes API error for app #{app_id}: #{e}"
      end
      nil
    end
  end
end 