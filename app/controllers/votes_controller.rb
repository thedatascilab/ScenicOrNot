class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params.merge(place_id: params[:place_id], uuid: uuid))

    if vote.save
      flash[:notice] = "You've just rated: #{vote.place.title} Your rating: #{vote.rating}"
    else
      flash[:error] = t("votes.duplicate")
    end

    redirect_to root_path
  end

  private

  def vote_params
    params.require(:vote).permit(:rating)
  end

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end
end
