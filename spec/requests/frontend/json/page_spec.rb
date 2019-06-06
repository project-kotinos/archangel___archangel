# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Root Page (JSON)", type: :request do
  describe "with available page" do
    it "returns successfully" do
      create(:page, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:ok)
    end

    it "returns successfully with JSON schema" do
      create(:page, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/pages/show")
    end

    it "returns successfully when parent is unavailable" do
      create(:page, :unpublished, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with homepage" do
    it "redirects to root path when Site homepage_redirect is true" do
      site = create(:site, homepage_redirect: true)
      create(:page, :homepage, site: site, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to redirect_to("/")
    end

    it "returns 301 status when Site homepage_redirect is true" do
      site = create(:site, homepage_redirect: true)
      create(:page, :homepage, site: site, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:moved_permanently)
    end

    it "throws 404 when Site homepage_redirect is false" do
      site = create(:site, homepage_redirect: false)
      create(:page, :homepage, site: site, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with unavailable page" do
    it "returns 404 when page is unpublished" do
      create(:page, :unpublished, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is future published" do
      create(:page, :future, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is deleted" do
      create(:page, :deleted, slug: "foo")

      get "/foo", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when page is not found" do
    it "returns 404" do
      get "/broken", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 with JSON schema" do
      get "/broken", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/errors/not_found")
    end
  end
end
