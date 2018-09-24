# frozen_string_literal: true

FactoryBot.define do
  factory :site, class: "Archangel::Site" do
    initialize_with { Archangel::Site.first_or_create }

    sequence(:name) { |n| "Site #{n} Name" }
    locale { "en" }
    meta_keywords { "default,keywords,of,my,site" }
    meta_description { "Default description of my site" }

    trait :logo do
      logo { fixture_file_upload(uploader_test_image) }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
