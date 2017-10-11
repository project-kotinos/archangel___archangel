# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Asset, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:file) }
      it { expect(subject).to validate_presence_of(:file_name) }

      it { expect(subject).to allow_value("success.jpg").for(:file_name) }

      it do
        expect(subject).not_to allow_value("without-extension").for(:file_name)
      end
      it do
        expect(subject).not_to allow_value("with.dot.jpg").for(:file_name)
      end
      it do
        expect(subject).not_to allow_value("with space.jpg").for(:file_name)
      end
    end

    context "callbacks" do
      it { expect(subject).to callback(:save_asset_attributes).before(:save) }
    end
  end
end
