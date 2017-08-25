class AddRecordService
  def initialize(data)
    @sides = data[:sides]
    @condition = data[:condition]
    @album = data[:album]
  end

  def perform
    album = Album.find_or_initialize_by(title: @album[:title], 
                                        album_type: @album[:album_type],
                                        released: @album[:released],
                                        artist: @album[:artist])
    record = Record.new(sides: @sides, 
                        condition: @condition)

    album.records << record 
    album.save
    
    record
  end
end
