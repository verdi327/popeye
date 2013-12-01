namespace :utility do
  desc "pings heroku server so we have no sad users"
  task :ping_heroku => :environment do
    conn = Faraday.new("http://get-popeye.herokuapp.com")
    conn.get
  end
end
