class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params.merge(place_id: params[:place_id]))

    if vote.save
      flash[:notice] = "You've just rated: #{vote.place.title} Your rating: #{vote.rating}"
    else
      flash.now[:error] = t("votes.duplicate")
    end

    redirect_to root_path
  end

  private

  def vote_params
    params.require(:vote).permit(:rating, :uuid)
  end
end
