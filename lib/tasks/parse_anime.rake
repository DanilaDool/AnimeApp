require 'open-uri'
require 'nokogiri'
require 'json'

namespace :parse_anime do
  task parse_data: :environment do
    url = 'https://kodikapi.com/list?token=5806763453666325d912b64d6031b627'

    begin
      html = URI.open(url).read
      data = JSON.parse(html)

      data.each do |shikimori_id|
        anime = Anime.find_or_initialize_by(shikimori_id: shikimori_id)

        anime.title = get_anime_title(shikimori_id, url)

      end

    rescue OpenURI::HTTPError => e
      puts "HTTP-ошибка: #{e.message}"
    rescue => e
      puts "Ошибка: #{e.message}"
    end
  end

end

def get_anime_title(shikimori_id, url)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  anime_data = api_request(url)

  return "Unknown Title" unless anime_data

  title = anime_data['russian'] || anime_data['name'] || "Unknown Title"
  puts "Anime title for shikimori_id #{shikimori_id}: #{title}"
  sleep(1)
  title
end