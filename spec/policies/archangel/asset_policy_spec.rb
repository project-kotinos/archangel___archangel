# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe AssetPolicy, type: :policy do
    subject { described_class.new(user, record) }

    let(:record) { create(:asset) }

    context "with `admin` role" do
      let(:user) { create(:user, :admin) }

      it { is_expected.to permit(:index) }
      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:new) }
      it { is_expected.to permit(:create) }
      it { is_expected.to permit(:edit) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:destroy) }

      it { is_expected.to permit(:wysiwyg) }
    end

    context "with `editor` role" do
      let(:user) { create(:user, :editor) }

      it { is_expected.to permit(:index) }
      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:new) }
      it { is_expected.to permit(:create) }
      it { is_expected.to permit(:edit) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:destroy) }

      it { is_expected.to permit(:wysiwyg) }
    end
  end
end
