class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params.merge(place_id: params[:place_id], uuid: uuid))

    if vote.save
      session[:just_rated_place_id] = vote.place_id
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
