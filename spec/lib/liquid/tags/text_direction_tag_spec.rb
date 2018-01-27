# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe TextDirectionTag, type: :tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "returns `ltr` text direction",
           disable: :verify_partial_doubles do
          allow(view).to receive(:text_direction).and_return("ltr")

          result = ::Liquid::Template.parse("{% text_direction %}")
                                     .render(context)

          expect(result).to eq("ltr")
        end

        it "returns `rtl` text direction",
           disable: :verify_partial_doubles do
          allow(view).to receive(:text_direction).and_return("rtl")

          result = ::Liquid::Template.parse("{% text_direction %}")
                                     .render(context)

          expect(result).to eq("rtl")
        end
      end
    end
  end
end
