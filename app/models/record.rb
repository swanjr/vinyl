class Record < ApplicationRecord
  belongs_to :album

  validates :title, presence: true
  validates :condition, inclusion: { in: %w(M NM VG+ VG G+ G F P) }, 
    allow_blank: true
end
