# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # YouTube custom tag for Liquid
      #
      # Example
      #   Given the YouTube URL https://www.youtube.com/watch?v=-X2atEH7nCg
      #   {% youtube "-X2atEH7nCg" %}
      #   {% youtube "-X2atEH7nCg" width:800 height:600 %}
      #   {% youtube "-X2atEH7nCg" id:"my_video" class:"my-video" %}
      #   {% youtube "-X2atEH7nCg" autoplay:1 %}
      #   {% youtube "-X2atEH7nCg" captions: %}
      #   {% youtube "-X2atEH7nCg" loop:1 %}
      #   {% youtube "-X2atEH7nCg" annotations:1 %}
      #   {% youtube "-X2atEH7nCg" start:10 %}
      #   {% youtube "-X2atEH7nCg" end:60 %}
      #   {% youtube "-X2atEH7nCg" showinfo:0 %}
      #   {% youtube "-X2atEH7nCg" allowfullscreen: %}
      #   {% youtube "-X2atEH7nCg" allowtransparency:0 %}
      #   {% youtube "-X2atEH7nCg" frameborder:4 %}
      #
      class YoutubeTag < ApplicationTag
        ##
        # YouTube video embed for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = SLUG_ATTRIBUTES_SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.youtube")
          end

          @key = ::Liquid::Variable.new(match[:slug], options).name
          @attributes = {}

          match[:attributes].scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the YouTube video
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered video
        #
        def render(_context)
          return if key.blank?

          content_tag(:iframe, "", video_attributes)
        end

        protected

        attr_reader :attributes, :key

        def video_attributes
          {
            src: video_url,
            width: video_width,
            height: video_height
          }.merge(video_fetch_attributes)
        end

        def video_fetch_attributes
          {
            id: nil,
            class: nil,
            style: nil,
            frameborder: 0,
            allowtransparency: "true",
            allowFullScreen: "allowFullScreen"
          }.each_with_object({}) do |(key, value), hash|
            hash[key] = attributes.fetch(key.to_s.downcase.to_sym, value)
          end
        end

        def video_url
          [
            "https://www.youtube.com/embed/#{key}",
            video_url_params
          ].join("?")
        end

        def video_url_params
          {
            ecver: 1,
            autohide: 2,
            cc_load_policy: attributes.fetch(:captions, 0),
            iv_load_policy: attributes.fetch(:annotations, 0),
            width: video_width,
            height: video_height
          }.merge(video_url_fetch_params)
            .compact.reject { |_, value| value.blank? }.to_query
        end

        def video_url_fetch_params
          {
            color: "red",
            autoplay: 0,
            loop: 0,
            showinfo: 1,
            start: nil,
            end: nil
          }.each_with_object({}) do |(key, value), hash|
            hash[key] = attributes.fetch(key.to_sym, value)
          end
        end

        def video_width
          attributes.fetch(:width, 640)
        end

        def video_height
          attributes.fetch(:height, 360)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("youtube", Archangel::Liquid::Tags::YoutubeTag)
