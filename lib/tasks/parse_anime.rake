namespace :parse_anime do
  task parse_data: :environment do
    url = 'https://kodikapi.com/list?token=5806763453666325d912b64d6031b627&types=anime-serial&with_material_data=true'

    begin
      json_data = URI.open(url).read
      data = JSON.parse(json_data)

      data['results'].each do |anime_data|
        shikimori_id = anime_data['shikimori_id']
        anime = Anime.find_or_initialize_by(shikimori_id: shikimori_id)
        material_data = anime_data['material_data']

        other_titles_jp = material_data['other_titles_jp']

        chines_or_japan = nil

      if other_titles_jp != nil
        other_titles_jp.each do |title|
          if title =~ /[\p{Hiragana}\p{Katakana}A-Za-z]/
            chines_or_japan = true
          else
            chines_or_japan = false
          end
        end
      end

        if anime.shikimori_id != nil && anime_data['type'] == "anime-serial" && material_data.present? && chines_or_japan == true

          if anime.anime_img.nil? || anime.anime_img.empty?
            anime.anime_img = cover_url(shikimori_id)
          end

          anime.id_anime = anime_data['id']
          anime.title = anime_data['title'].gsub(/\s*\[ТВ-(\d+).*?\]\s*/, ' \1')
          anime.title_orig = anime_data['title_orig']
          anime.other_title = anime_data['other_title']
          anime.date = anime_data['year']
          anime.dtype = anime_data['type']
          anime.created_at = anime_data['created_at']
          anime.updated_at = anime_data['updated_at']
          anime.link = anime_data['link']
          anime.not_blocked_in = anime_data['not_blocked_in']
          anime.not_blocked_for_me = anime_data['not_blocked_for_me']
          anime.last_season = anime_data['last_season']
          anime.last_episode = anime_data['last_episode']
          anime.episodes_count = anime_data['episodes_count']
          anime.shikimori_id = anime_data['shikimori_id']
          anime.kinopoisk_id = anime_data['kinopoisk_id']
          anime.worldart_link = anime_data['worldart_link']
          anime.imdb_id = anime_data['imdb_id']
          anime.mdl_id = anime_data['mdl_id']
          anime.quality = anime_data['quality']
          anime.camrip = anime_data['camrip']
          anime.lgbt = anime_data['lgbt']
          anime.blocked_countries = anime_data['blocked_countries']
          anime.blocked_seasons = anime_data['blocked_seasons']
          anime.screenshots = anime_data['screenshots']
          anime.translation = anime_data['translation']
          anime.genres = material_data['all_genres']
          anime.age_limit = material_data['minimal_age']
          anime.score = get_anime_score(shikimori_id)
          anime.status = get_anime_status(shikimori_id)
          anime.rating_mpaa = get_anime_rating_mpaa(shikimori_id)
          anime.next_episode_at = get_anime_next_episode_at(shikimori_id)
          anime.studios = get_anime_studios(shikimori_id)
          anime.videos = get_anime_videos(shikimori_id)
          anime.duration = get_anime_duration(shikimori_id)
          anime.description = get_anime_description(shikimori_id)

          if anime.next_episode_at.nil?
            anime.next_episode_at = material_data['next_episode_at']
          end

          if anime.duration.nil?
            anime.duration = material_data['duration']
          end

          if anime.status.nil? || anime.status.empty?
            anime.status = material_data['anime_status']
          end

          if anime.score.nil?
            anime.score = material_data['shikimori_rating']
          end

          if anime.rating_mpaa.nil? || anime.rating_mpaa.empty?
            anime.rating_mpaa = material_data['rating_mpaa']
          end

          if anime.genres.nil? || anime.genres.empty?
            anime.genres = material_data['anime_genres']
          end

          if anime.description == nil
            anime.description = material_data['description']
          elsif !material_data['description'].present?
            anime.description = material_data['anime_description']
          end

          if anime_data['material_data']
            anime.material_data = anime_data['material_data']
            puts "Assigned Material Data: #{anime.material_data.inspect}"
          else
            anime.material_data = {}
          end


          puts "id for anime:#{anime.id_anime}"
          puts "Title for anime:#{anime.title}"
          puts "score for anime:#{anime.score}"
          puts "status for anime:#{anime.status}"
          puts "anime_img for anime:#{anime.anime_img}"
          puts "Title_orig for anime:#{anime.title_orig}"
          puts "Other_title for anime:#{anime.other_title}"
          puts "Year for anime:#{anime.date}"
          puts "Type for anime:#{anime.dtype}"
          puts "created_at for anime:#{anime.created_at}"
          puts "updated_at for anime:#{anime.updated_at}"
          puts "link for anime:#{anime.link}"
          puts "not_blocked_in for anime:#{anime.not_blocked_in}"
          puts "not_blocked_for_me for anime:#{anime.not_blocked_for_me}"
          puts "last_season for anime:#{anime.last_season}"
          puts "last_episode for anime:#{anime.last_episode}"
          puts "episodes_count for anime:#{anime.episodes_count}"
          puts "shikimori_id for anime:#{anime.shikimori_id}"
          puts "kinopoisk_id for anime:#{anime.kinopoisk_id}"
          puts "worldart_link for anime:#{anime.worldart_link}"
          puts "imdb_id for anime:#{anime.imdb_id}"
          puts "mdl_id for anime:#{anime.mdl_id}"
          puts "quality for anime:#{anime.quality}"
          puts "camrip for anime:#{anime.camrip}"
          puts "lgbt for anime:#{anime.lgbt}"
          puts "blocked_countries for anime:#{anime.blocked_countries}"
          puts "blocked_seasons for anime:#{anime.blocked_seasons}"
          puts "screenshots for anime:#{anime.screenshots}"
          puts "translation for anime:#{anime.translation}"
          puts "genres for anime:#{anime.genres}"
          puts "rating_mpaa for anime:#{anime.rating_mpaa}"
          puts "next_episode_at for anime:#{anime.next_episode_at}"
          puts "studios for anime:#{anime.studios}"
          puts "videos for anime:#{anime.videos}"
          puts "duration for anime:#{anime.duration}"
          puts "description for anime:#{anime.description}"
          puts "material_data for anime: #{anime.material_data}"

          puts

          anime.save
        end
      end
    rescue OpenURI::HTTPError => e
      puts "HTTP-ошибка: #{e.message}"
    rescue => e
      puts "Ошибка: #{e.message}"
    end
  end
end

def contains_chines?(text)
  !!(text =~ /[\u4E00-\u9FFF\u3400-\u4DBF\u20000-\u2A6DF\u2A700-\u2B73F\u2B740-\u2B81F\u2B820-\u2CEAF]/)
end


def cover_url(shikimori_id)
  "https://shikimori.one/system/animes/original/#{shikimori_id}.jpg"
end

def get_anime_status(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      anime_data = JSON.parse(response.body)

      status = anime_data['status']

      return status
    end
end

def get_anime_description(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    description = anime_data['description']

    if description == nil
      description
    end

    return description
  end
end

def get_anime_duration(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    duration = anime_data['duration']

    return duration
  end
end

def get_anime_videos(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    videos = anime_data['videos']

    return videos
  end
end

def get_anime_studios(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    studios = anime_data['studios']

    return studios
  end
end

def get_anime_rating_mpaa(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    rating_mpaa = anime_data['rating']

    return rating_mpaa
  end
end

def get_anime_next_episode_at(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    next_episode_at = anime_data['next_episode_at']

    return next_episode_at
  end
end

def get_anime_genres(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)

    genres = anime_data['genres']

    return genres
  end
end

def get_anime_score(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      anime_data = JSON.parse(response.body)
      score = anime_data['score'].to_f

      return score
    end
  end
