# frozen_string_literal: true

module Archangel
  class BackendController < ApplicationController
    include Pundit

    include Archangel::AuthenticatableConcern
    include Archangel::AuthorizableConcern

    rescue_from Pundit::NotAuthorizedError, with: :render_401

    protected

    def load_site_layout
      "archangel/layouts/backend"
    end
  end
end
