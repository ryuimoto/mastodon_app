task :toot => :environment do

    client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

    response = client.create_status("シリコンバレー面白いですよ")

end