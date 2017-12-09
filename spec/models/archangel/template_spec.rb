# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Template, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:content) }
      it { expect(subject).to validate_presence_of(:name) }

      it { expect(subject).to allow_value(true).for(:partial) }
      it { expect(subject).to allow_value(false).for(:partial) }
      it { expect(subject).not_to allow_value(nil).for(:partial) }

      it { expect(subject).to allow_value("{{ foo }}").for(:content) }
      it { expect(subject).not_to allow_value("{{ foo }").for(:content) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:parent) }
      it { expect(subject).to belong_to(:site) }
    end
  end
end
