class Record < ApplicationRecord
  belongs_to :album

  validates :condition, inclusion: { in: %w(M NM VG+ VG G+ G F P) } 
end
