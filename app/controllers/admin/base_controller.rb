class Admin::BaseController < ApplicationController
  before_filter :check_auth!

  private
  def check_auth!
    authorize! :access, :admin
  end
end