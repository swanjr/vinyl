FactoryGirl.define do
  factory :record, class: Record do
    sides '1,2'
    condition 'VG+'
    album
  end
end
