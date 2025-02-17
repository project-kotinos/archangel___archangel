# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe YoutubeTag, type: :liquid_tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "raises error with invalid syntax" do
          content = "{% youtube %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns default YouTube embed" do
          result = ::Liquid::Template.parse("{% youtube '-X2atEH7nCg' %}")
                                     .render(context)

          expect(result).to include("https://www.youtube.com/embed/-X2atEH7nCg")
          expect(result).to include("width=\"640\"")
          expect(result).to include("height=\"360\"")
        end

        it "returns YouTube embed with options" do
          content = "{% youtube '-X2atEH7nCg' width:800 height:600 %}"
          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("https://www.youtube.com/embed/-X2atEH7nCg")
          expect(result).to include("width=\"800\"")
          expect(result).to include("height=\"600\"")
        end
      end
    end
  end
end
