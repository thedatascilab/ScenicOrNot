RSpec.describe "Voting", type: :request do
  it "redirects to the index page when a vote is successful" do
    uuid = SecureRandom.uuid
    place_stub = double(:place, title: "Place title")
    vote_stub = double(:vote, save: true, place: place_stub, rating: "4")

    expect(Vote).to receive(:new).with(
      ActionController::Parameters.new({
        rating: "4",
        uuid: uuid,
        place_id: "123"
      }).permit!
    ).and_return(vote_stub)

    post("/places/123/votes", params: {vote: {rating: 4, uuid: uuid}})

    expect(response).to redirect_to(root_path)

    expect(flash[:error]).to be_nil
  end

  it "flashes an error message when the vote is unsuccessful" do
    uuid = SecureRandom.uuid
    vote_stub = double(:vote, save: false)

    expect(Vote).to receive(:new).with(
      ActionController::Parameters.new({
        rating: "4",
        uuid: uuid,
        place_id: "123"
      }).permit!
    ).and_return(vote_stub)

    post("/places/123/votes", params: {vote: {rating: 4, uuid: uuid}})

    expect(flash[:error]).to eq(I18n.t("votes.duplicate"))
  end
end
