class TitlesController < ApplicationController
  autocomplete :title, :name, full: true

  def index
    @titles = Title.order(:name)
  end
end
