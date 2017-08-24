class Album < ApplicationRecord
  has_many :records
  has_and_belongs_to_many :artists 
 
  validates :name, presence: true
  validates :album_type, inclusion: { in: %w(album single compilation) }
end
