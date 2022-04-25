class DataDownloadsController < ActionController::Base
  layout "application"

  def index
    @local_authorities = LocalAuthority.alphabetical
  end
end
