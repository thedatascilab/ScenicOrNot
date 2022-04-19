class Vote < ApplicationRecord
  belongs_to :place

  validates_uniqueness_of :uuid, scope: :place
end
