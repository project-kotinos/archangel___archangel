# frozen_string_literal: true

FactoryBot.define do
  factory :template, class: "Archangel::Template" do
    site
    sequence(:name) { |n| "Template #{n} Name" }
    content do
      "<p>BEFORE TEMPLATE<p>
       <p>{{ content_for_layout }}<p>
       <p>AFTER TEMPLATE<p>"
    end
    partial { false }

    trait :partial do
      partial { true }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
