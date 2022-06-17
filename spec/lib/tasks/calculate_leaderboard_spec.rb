RSpec.describe "leaderboard:calculate_and_store", type: :task do
  let(:fake_leaderboard) { {most_scenic_places: [], least_scenic_places: [], percentage_rated: 0.0} }
  let(:json_data) { '{"most_scenic_places":[],"least_scenic_places":[],"percentage_rated":0.0}' }

  before do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:write)
    allow_any_instance_of(Leaderboard).to receive(:as_json).and_return(fake_leaderboard)
  end

  it "calculates the leaderboard and stores it in a file" do
    expect(FileUtils).to receive(:mkdir_p).with("tmp/test")
    expect(File).to receive(:write).with("tmp/test/leaderboard.json", json_data)

    task.execute
  end
end
