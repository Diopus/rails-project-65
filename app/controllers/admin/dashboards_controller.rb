# frozen_string_literal: true

module Admin
  class DashboardsController < ApplicationController
    def index
      @bulletins = Bulletin.under_moderation
    end
  end
end
