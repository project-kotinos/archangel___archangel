# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Nested Page (JSON)", type: :request do
  describe "with available page" do
    it "returns successfully" do
      parent_a = create(:page, slug: "foo")
      create(:page, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:ok)
    end

    it "returns successfully with JSON schema" do
      parent_a = create(:page, slug: "foo")
      create(:page, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/pages/show")
    end

    it "returns successfully when parent is unavailable" do
      parent_a = create(:page, :unpublished, slug: "foo")
      create(:page, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "with homepage" do
    it "redirects to root path when Site homepage_redirect is true" do
      site = create(:site, homepage_redirect: true)
      parent_a = create(:page, site: site, slug: "foo")
      create(:page, :homepage, site: site, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to redirect_to("/")
    end

    it "returns 301 status when Site homepage_redirect is true" do
      site = create(:site, homepage_redirect: true)
      parent_a = create(:page, site: site, slug: "foo")
      create(:page, :homepage, site: site, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:moved_permanently)
    end

    it "throws 404 when Site homepage_redirect is false" do
      site = create(:site, homepage_redirect: false)
      parent_a = create(:page, site: site, slug: "foo")
      create(:page, :homepage, site: site, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with unavailable page" do
    it "returns 404 when page is unpublished" do
      parent_a = create(:page, slug: "foo")
      create(:page, :unpublished, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is future published" do
      parent_a = create(:page, slug: "foo")
      create(:page, :future, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is deleted" do
      parent_a = create(:page, slug: "foo")
      create(:page, :deleted, parent: parent_a, slug: "bar")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when page is not found" do
    it "returns 404 status" do
      create(:page, slug: "foo")

      get "/foo/broken", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 with JSON schema" do
      get "/foo/broken", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/errors/not_found")
    end
  end
end
