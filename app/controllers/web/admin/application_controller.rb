# frozen_string_literal: true

module Web
  class Admin::ApplicationController < ApplicationController
    before_action :authenticate_admin!

    layout 'web/admin/layouts/application'
  end
end
