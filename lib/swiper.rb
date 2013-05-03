class Swiper

  attr_accessor :track1

  def self.can_parse?(swiped_data)
    !swiped_data.nil? && swiped_data.start_with?('%B') && !swiped_data.scan(/^%(.*)\?;(.*)\?$/)[0].nil?
  end
  
  def self.cant_parse?(swiped_data)
    !can_parse?(swiped_data)
  end

  def initialize
    @track1 = Swiper::Track1.new
  end

  def self.parse(swiped_data)
    return false if cant_parse?(swiped_data)
      
    tracks = swiped_data.scan(/^%(.*)\?;(.*)\?$/)
    raw_track1 = tracks[0][0]
    track1_groups = raw_track1.scan(/^(.)(\d*)\^([^\/]*)\/(.*)\^(..)(..)(.*)$/)
      
    card_data = Swiper.new
    card_data.track1.raw = raw_track1
    card_data.track1.track_format = track1_groups[0][0]
    card_data.track1.primary_account_number = track1_groups[0][1]
    card_data.track1.cardholder_name = track1_groups[0][3].strip + ' ' + track1_groups[0][2].strip
    card_data.track1.expiration_month = track1_groups[0][5]
    card_data.track1.expiration_year = track1_groups[0][4]
    
    card_data
  end

  class Track1
    attr_accessor :raw, 
                  :track_format,
                  :primary_account_number,
                  :cardholder_name,
                  :expiration_month,
                  :expiration_year
  end
end