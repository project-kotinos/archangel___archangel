# frozen_string_literal: true

module Archangel
  ##
  # Archangel custom Liquid resources
  #
  module Liquid
    ##
    # Liquid Drop for singular resources
    #
    class Drop < ::Liquid::Drop
      class << self
        attr_accessor :_associations
        attr_accessor :_attributes
      end

      def self.inherited(base)
        base._attributes   = []
        base._associations = {}
      end

      def self.attributes(*attrs)
        @_attributes.concat attrs

        attrs.each do |attr|
          next if method_defined?(attr)

          define_method(attr) do
            object.send(attr) if object.methods.include?(attr)
          end
        end
      end

      def initialize(object, _options = {})
        @object = object
      end

      def attributes
        @attributes ||=
          self.class._attributes.dup.each_with_object({}) do |name, hash|
            hash[name.to_s] = send(name)
          end
      end

      def as_json(options = {})
        attributes.as_json(options)
      end

      def to_json(options = {})
        as_json.to_json(options)
      end

      def inspect
        "#<#{self.class.name} " \
          "@object: #{object.inspect} @attributes: #{attributes.inspect}>"
      end

      protected

      attr_reader :object
    end
  end
end
