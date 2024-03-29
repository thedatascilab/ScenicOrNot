# frozen_string_literal: true

Rails.application.routes.draw do
  # If the CANONICAL_HOSTNAME env var is present, and the request doesn't come from that
  # hostname, redirect us to the canonical hostname with the path and query string present
  if ENV["CANONICAL_HOSTNAME"].present?
    constraints(host: Regexp.new("^(?!#{Regexp.escape(ENV["CANONICAL_HOSTNAME"])})")) do
      match "/(*path)" => redirect(host: ENV["CANONICAL_HOSTNAME"]), :via => [:all]
    end
  end

  get "health_check" => "application#health_check"

  root to: "places#vote"

  resources :places, only: [:show] do
    get "vote", to: "places#vote"
    resources :votes, only: [:create]
  end

  get "faq" => "faq#show"
  get "cookies" => "cookies#show"
  get "leaderboard" => "places#leaderboard"

  resources :data_downloads, only: [:index]
end
