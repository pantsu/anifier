class ReleaseObserver < ActiveRecord::Observer
  observe :release

  def after_create(release)
    # unless Motification
  end
end