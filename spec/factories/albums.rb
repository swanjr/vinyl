FactoryGirl.define do
  factory :album, class: Album do
    title 'Greatest Hits'
    album_type 'Album'
    artist 'John Doe' 
    released 'Jan 2008'
  end
end
