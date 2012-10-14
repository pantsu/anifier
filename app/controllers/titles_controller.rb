class TitlesController < ApplicationController
  autocomplete :title, :name, full: true
end