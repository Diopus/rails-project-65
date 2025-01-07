# frozen_string_literal: true

module Admin
  class DashboardsController < ApplicationController
    def index
      @bulletins = Bulletin.all
    end
  end
end
