# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Widget custom tag for Liquid
      #
      # Example
      #   {% widget "widget-name" %}
      #   {% widget 'widget-name' %}
      #   {% widget widget-name %}
      #
      class WidgetTag < ApplicationTag
        ##
        # {% widget 'slug' %}
        #
        SYNTAX = /(?<slug>#{::Liquid::QuotedFragment}+)?\s*/o

        def initialize(tag_name, markup, options)
          super

          match = SYNTAX.match(markup)

          raise SyntaxError, Archangel.t("errors.syntax.widget") if match.blank?

          @slug = ::Liquid::Variable.new(match[:slug], options).name
        end

        ##
        # Render the Widget
        #
        # @param context [Object] the Liquid context
        # @return [String] the rendered Widget
        #
        def render(context)
          return if slug.blank?

          environments = context.environments.first
          site = environments["site"]

          widget = load_widget_for(site)

          return if widget.blank?

          rendered_widget = render_widget(widget.content, environments)

          template = widget.template

          if template.present?
            rendered_widget = render_templated_widget(template, rendered_widget)
          end

          rendered_widget
        end

        protected

        attr_reader :slug

        def load_widget_for(site)
          site.widgets.find_by!(slug: slug)
        rescue StandardError
          nil
        end

        def render_widget(content, assigns)
          Archangel::RenderService.call(content, assigns)
        end

        def render_templated_widget(template_content, widget_content)
          Archangel::TemplateRenderService.call(
            template_content,
            content_for_layout: widget_content
          )
        end
      end
    end
  end
end

::Liquid::Template.register_tag("widget", Archangel::Liquid::Tags::WidgetTag)
