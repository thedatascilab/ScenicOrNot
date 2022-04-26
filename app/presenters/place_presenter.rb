class PlacePresenter < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  def score
    number_with_precision(votes.average(:rating), precision: 2, strip_insignificant_zeros: true)
  end

  def vote_count
    votes.count
  end
end
