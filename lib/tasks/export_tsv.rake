desc "Export a TSV summarising the most recent data in the database"
task export_tsv: :environment do
  require "fileutils"
  FileUtils.mkdir_p "tmp"

  votes_file = File.open("tmp/votes.tsv", "wb")
  votes_file.write(ExportPlacesWithVotes.new.tsv_data)
  votes_file.close
end
