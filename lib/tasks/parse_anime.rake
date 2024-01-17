require 'net/http'
require 'json'

namespace :parse_anime do
  desc 'Parse anime data from API and download covers'
  task :parse_data => :environment do
    url = 'https://api-movies.github.io/kodik/movie_shikimori_ids.json'
    uri = URI(url)

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    data.each do |shikimori_id|
      anime = Anime.find_or_initialize_by(shikimori_id: shikimori_id)

      # Check if the anime_img attribute is already present
      if anime.anime_img.nil? || anime.anime_img.empty?
        # Set the anime_img attribute
        anime.anime_img = download_cover_url(shikimori_id)
      end

      anime.title = get_anime_title(shikimori_id)
      anime.score = get_anime_score(shikimori_id)
      anime.date = get_anime_air_date(shikimori_id)
      anime.status = get_anime_status(shikimori_id)
      anime.dtype = get_anime_dtype(shikimori_id)

      if anime.save
        puts "Anime with shikimori_id #{shikimori_id} saved successfully!"
      else
        puts "Error saving anime with shikimori_id #{shikimori_id}: #{anime.errors.full_messages}"
      end
    end

    puts 'Anime data parsed successfully!'
  end
end

def download_cover_url(shikimori_id)
  cover_url = "https://shikimori.one/system/animes/original/#{shikimori_id}.jpg"

  cover_url
end


def get_anime_score(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  max_retries = 3
  retries = 0

  begin
    response = Net::HTTP.get_response(uri)

    # Check if the response is successful (status code 200)
    if response.is_a?(Net::HTTPSuccess)
      anime_data = JSON.parse(response.body)
      # Extract and return the anime score
      score = anime_data['score'].to_f
      if score
        puts "Score for anime with shikimori_id #{shikimori_id}: #{score}"
        sleep(1)
        return score
      else
        puts "Score not found for anime with shikimori_id #{shikimori_id}"
        return "Unknown Score"
      end
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{response.message}"
      puts "Response body: #{response.body}"
      return "Unknown Score"
    end
  rescue StandardError => e
    if e.message.include?("Retry later") && retries < max_retries
      puts "Retrying after waiting..."
      retries += 1
      sleep(1)  # Подождите некоторое время перед повторной попыткой
      retry
    elsif e.message.include?("Too Many Requests")
      puts "Too Many Requests. Retrying after waiting..."
      sleep(60)  # Подождите минуту перед повторной попыткой
      retry
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{e.message}"
      return "Unknown Score"
    end
  end
end

def get_anime_air_date(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  max_retries = 3
  retries = 0

  begin
    response = Net::HTTP.get_response(uri)

    # Check if the response is successful (status code 200)
    if response.is_a?(Net::HTTPSuccess)
      anime_data = JSON.parse(response.body)
      # Extract and return the anime air date
      aired_on = anime_data['aired_on']
      if aired_on
        puts "Air date for anime with shikimori_id #{shikimori_id}: #{aired_on}"
        sleep(1)
        return aired_on
      else
        puts "Air date not found for anime with shikimori_id #{shikimori_id}"
        return "Unknown Air Date"
      end
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{response.message}"
      puts "Response body: #{response.body}"
      return "Unknown Air Date"
    end
  rescue StandardError => e
    if e.message.include?("Retry later") && retries < max_retries
      puts "Retrying after waiting..."
      retries += 1
      sleep(1)  # Подождите некоторое время перед повторной попыткой
      retry
    elsif e.message.include?("Too Many Requests")
      puts "Too Many Requests. Retrying after waiting..."
      sleep(60)  # Подождите минуту перед повторной попыткой
      retry
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{e.message}"
      return "Unknown Air Date"
    end
  end
end

def get_anime_status(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  max_retries = 3
  retries = 0

  begin
    response = Net::HTTP.get_response(uri)

    # Check if the response is successful (status code 200)
    if response.is_a?(Net::HTTPSuccess)
      anime_data = JSON.parse(response.body)
      # Extract and return the anime status
      status = anime_data['status']
      if status
        puts "Status for anime with shikimori_id #{shikimori_id}: #{status}"
        sleep(1)  # Подождите 5 секунд перед следующим запросом
        return status
      else
        puts "Status not found for anime with shikimori_id #{shikimori_id}"
        return "Unknown Status"
      end
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{response.message}"
      puts "Response body: #{response.body}"
      return "Unknown Status"
    end
  rescue StandardError => e
    if e.message.include?("Retry later") && retries < max_retries
      puts "Retrying after waiting..."
      retries += 1
      sleep(1)  # Подождите некоторое время перед повторной попыткой
      retry
    elsif e.message.include?("Too Many Requests")
      puts "Too Many Requests. Retrying after waiting..."
      sleep(60)  # Подождите минуту перед повторной попыткой
      retry
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{e.message}"
      return "Unknown Status"
    end
  end
end

def translate_status(status)
  case status
  when "released"
    return "вышло"
  when "ongoing"
    return "в процессе"
    # Добавьте другие переводы по необходимости
  else
    return status
  end
end

def get_anime_dtype(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  max_retries = 3
  retries = 0

  begin

    response = Net::HTTP.get_response(uri)

  # Check if the response is successful (status code 200)
  if response.is_a?(Net::HTTPSuccess)
    anime_data = JSON.parse(response.body)
    # Extract and return the anime status
    dtype = anime_data['kind']

    if dtype
      puts "dtype for anime with shikimori_id #{shikimori_id}: #{dtype}"
      sleep(1)  # Подождите 5 секунд перед следующим запросом
      return dtype
    else
      puts "dtype not found for anime with shikimori_id #{shikimori_id}"
      return "Unknown dtype"
    end
  else
    puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{response.message}"
    puts "Response body: #{response.body}"
    return "Unknown dtype"
  end
rescue StandardError => e
  if e.message.include?("Retry later") && retries < max_retries
    puts "Retrying after waiting..."
    retries += 1
    sleep(1)  # Подождите некоторое время перед повторной попыткой
    retry
  elsif e.message.include?("Too Many Requests")
    puts "Too Many Requests. Retrying after waiting..."
    sleep(60)  # Подождите минуту перед повторной попыткой
    retry
  else
    puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{e.message}"
    return "Unknown dtype"
  end
 end
end

def get_anime_title(shikimori_id)
  url = "https://shikimori.one/api/animes/#{shikimori_id}"
  uri = URI(url)

  max_retries = 3
  retries = 0

  begin
    response = Net::HTTP.get_response(uri)

    # Check if the response is successful (status code 200)
    if response.is_a?(Net::HTTPSuccess)
      anime_data = JSON.parse(response.body)
      # Extract and return the anime title
      title = anime_data['russian'] || anime_data['name'] || "Unknown Title"
      puts "Anime title for shikimori_id #{shikimori_id}: #{title}"
      sleep(1)  # Подождите 5 секунд перед следующим запросом
      return title
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{response.message}"
      puts "Response body: #{response.body}"
      return "Unknown Title"
    end
  rescue StandardError => e
    if e.message.include?("Retry later") && retries < max_retries
      puts "Retrying after waiting..."
      retries += 1
      sleep(1)  # Подождите некоторое время перед повторной попыткой
      retry
    elsif e.message.include?("Too Many Requests")
      puts "Too Many Requests. Retrying after waiting..."
      sleep(60)  # Подождите минуту перед повторной попыткой
      retry
    else
      puts "Error fetching data for anime with shikimori_id #{shikimori_id}: #{e.message}"
      return "Unknown Title"
    end
  end
end





