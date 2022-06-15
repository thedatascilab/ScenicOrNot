require "./app/models/leaderboard"

namespace :leaderboard do
  desc "Calculate leaderboard and store the results"
  task calculate_and_store: :environment do
    require "fileutils"
    FileUtils.mkdir_p "tmp/#{Rails.env}"

    leaderboard_data = JSON.generate(Leaderboard.new.as_json)
    File.write("tmp/#{Rails.env}/leaderboard.json", leaderboard_data)
  end
end
