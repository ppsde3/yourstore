class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "prashant", password: "1234", except: [:index]
  def show
  end
end
