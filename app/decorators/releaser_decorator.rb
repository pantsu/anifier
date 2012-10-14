class ReleaserDecorator < ApplicationDecorator
  decorates :releaser

  def description
    model.description || h.t('no_description')
  end

  def name_with_link
    name = h.t('releaser', name: model.name)
    model.url ? h.link_to(name, model.url) : name
  end
end