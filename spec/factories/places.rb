FactoryBot.define do
  factory :place do
    geograph_id { rand(0...10000) }
    title { Faker::Mountain.name }
    description { Faker::Mountain.range }
    subject { Faker::Hobby.activity }
    creator { Faker::Name.name }
    creator_uri { "http://www.geograph.org.uk/profile/#{rand(0...10000)}" }
    date_submitted { Faker::Date.between(from: 10.years.ago, to: Date.today).to_datetime }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    gridsquare {
      [
        ["S", "T", "N", "H"].sample,
        (("A".."K").to_a + ("M".."Z").to_a).sample,
        rand(1000..9999)
      ].join
    }
    license_uri { "http://creativecommons.org/licenses/by-sa/2.0/" }
    format { "image/jpeg" }
    vote_count { rand(0..100) }
    random { rand(0.0..1.0) }
    width { 640 }
    height { 480 }
    aspect { 1.33 }
  end
end
