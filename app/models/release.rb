class Release < ActiveRecord::Base
  attr_protected

  belongs_to :releaser
  belongs_to :title

  validates :raw, :title_id, :episodes, presence: true
  validates :raw, uniqueness: true

  define_index :releases do
    indexes audio, video, media
    indexes title(:title), as: :title, sortable: true
    set_property delta: true
    has releaser_id, created_at
  end
end
