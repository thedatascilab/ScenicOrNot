class LocalAuthority < ApplicationRecord
  scope :alphabetical, -> { order(:name) }

  DATA_HOSTNAME = "https://scenic-or-not.s3-eu-west-1.amazonaws.com"

  def filename
    "#{name.tr(" ", "_")}.tsv"
  end

  def data_url
    "#{ENV.fetch("DATA_HOSTNAME", DATA_HOSTNAME)}/#{filename}"
  end
end
