namespace :ping do
  desc "Send head request to HEROKU_HOST"
  task heroku: :environment do
    Net::HTTP.start(ENV['HEROKU_HOST']) do |http|
      http.open_timeout = 2
      http.read_timeout = 2
      http.head('/')
    end if ENV['HEROKU_HOST']
  end

end
