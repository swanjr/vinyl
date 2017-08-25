class Album < ApplicationRecord
  has_many :records, autosave: true

  validates :title, presence: true
  validates :album_type, inclusion: { in: %w(Album Single Compilation) }

end
