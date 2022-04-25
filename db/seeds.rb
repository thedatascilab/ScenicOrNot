if Rails.env.development?
  load File.join(Rails.root, "db", "seeds", "places.rb")
  load File.join(Rails.root, "db", "seeds", "votes.rb")
end

load File.join(Rails.root, "db", "seeds", "local_authorities.rb")
