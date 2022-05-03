class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params.merge(place_id: params[:place_id], uuid: uuid))

    # Under normal operating conditions the user should never be shown a place they've already rated
    # so we silently ignore duplicate votes to not disrupt the user's experience
    vote.save

    redirect_to root_path(just_rated_place_id: vote.place_id)
  end

  private

  def vote_params
    params.require(:vote).permit(:rating)
  end

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end
end
