namespace :ping do
  desc "Send head request to HEROKU_HOST"
  task heroku: :environment do
    Net::HTTP.start(ENV['HEROKU_HOST']) { |http| http.head('/') } if ENV['HEROKU_HOST']
  end

end
