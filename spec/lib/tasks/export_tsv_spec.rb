RSpec.describe "export_tsv", type: :task do
  let(:fake_file) { double(:file) }
  let(:fake_data) { double(:data) }

  before do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:open).and_return(fake_file)
    allow(fake_file).to receive(:write)
    allow(fake_file).to receive(:close)
    allow_any_instance_of(ExportPlacesWithVotes).to receive(:tsv_data).and_return(fake_data)
  end

  it "writes the TSV data into a file" do
    expect(FileUtils).to receive(:mkdir_p).with("tmp")
    expect(File).to receive(:open).with("tmp/votes.tsv", "wb")
    expect(fake_file).to receive(:write).with(fake_data)
    expect(fake_file).to receive(:close)

    task.execute
  end
end
