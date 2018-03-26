# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe AssetTag, type: :liquid_tag do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "raises error with invalid syntax" do
          content = "{% asset %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns image asset" do
          asset = create(:asset, site: site, file_name: "abc.jpg")

          result = ::Liquid::Template.parse("{% asset '#{asset.file_name}' %}")
                                     .render(context)
          expected = "<img alt=\"#{asset.file_name}\" " \
                     "src=\"/uploads/archangel/asset/file/"

          expect(result).to include(expected)
        end

        context "with `size` attribute" do
          %w[small tiny].each do |size|
            it "returns `#{size}` sized image asset" do
              asset = create(:asset, site: site, file_name: "abc.jpg")

              content = <<-LIQUID
                {% asset '#{asset.file_name}' size: '#{size}' %}
              LIQUID

              result = ::Liquid::Template.parse(content).render(context)
              expected = "<img alt=\"#{asset.file_name}\" " \
                         "src=\"/uploads/archangel/asset/" \
                         "file/#{asset.id}/#{size}_"

              expect(result).to include(expected)
            end
          end

          it "returns original image asset" do
            asset = create(:asset, site: site, file_name: "abc.jpg")

            content = <<-LIQUID
              {% asset '#{asset.file_name}' size: 'unknown_size' %}
            LIQUID

            result = ::Liquid::Template.parse(content).render(context)
            expected = "<img alt=\"#{asset.file_name}\" " \
                       "src=\"/uploads/archangel/asset/file/#{asset.id}/"

            expect(result).to include(expected)
          end
        end

        it "returns image with options" do
          asset = create(:asset, site: site, file_name: "abc.jpg")

          content = "{% asset '#{asset.file_name}' alt:'This is the alt tag' %}"
          result = ::Liquid::Template.parse(content).render(context)
          expected = "<img alt=\"This is the alt tag\" " \
                     "src=\"/uploads/archangel/asset/file/"

          expect(result).to include(expected)
        end

        it "returns nothing when asset not found" do
          result = ::Liquid::Template.parse("{% asset 'whatever.jpg' %}")
                                     .render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
