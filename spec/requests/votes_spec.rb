RSpec.describe "Voting", type: :request do
  let(:uuid) { "a1b2c3" }

  before do
    allow(SecureRandom).to receive(:uuid).and_return(uuid)
  end

  it "redirects to the index page when a vote is successful" do
    vote_stub = double(:vote, save: true, place_id: 123, rating: "4")

    expect(Vote).to receive(:new).with(
      ActionController::Parameters.new({
        rating: "4",
        uuid: uuid,
        place_id: "123"
      }).permit!
    ).and_return(vote_stub)

    post("/places/123/votes", params: {vote: {rating: 4}})

    expect(response).to redirect_to(root_path(just_rated_place_id: "123"))

    expect(flash[:error]).to be_nil
  end

  it "redirects to the index page when the vote is unsuccessful" do
    vote_stub = double(:vote, save: false, place_id: 123)

    expect(Vote).to receive(:new).with(
      ActionController::Parameters.new({
        rating: "4",
        uuid: uuid,
        place_id: "123"
      }).permit!
    ).and_return(vote_stub)

    post("/places/123/votes", params: {vote: {rating: 4}})

    expect(response).to redirect_to(root_path(just_rated_place_id: "123"))

    expect(flash[:error]).to be_nil
  end
end
