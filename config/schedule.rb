# config/schedule.rb

every 1.day, at: ['12:00 am', '8:00 am', '12:00 pm', '4:00 pm', '8:00 pm'] do
  rake 'parse_anime:parse_data'
end
