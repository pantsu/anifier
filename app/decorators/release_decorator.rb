class ReleaseDecorator < ApplicationDecorator

  def full_title
    "[#{model.releaser_name}] #{model.title_name} #{issue}"
  end

  def volume
    model.volume.blank? ? nil : I18n.t(:volume, value: model.volume)
  end

  def episodes
    model.episodes.blank? ? nil : I18n.t(:episodes, value: model.episodes)
  end

  def issue
    [volume, episodes].compact.join(", ")
  end

  def resolution
    model.resolution.blank? ? I18n.t(:unspecified) : "#{model.resolution}p"
  end

end