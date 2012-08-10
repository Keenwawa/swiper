require 'spec_helper'
describe Swiper do
  it "should tell you if it can parse the data" do
    Swiper.can_parse?('%B').should be_true
    Swiper.can_parse?('3').should be_false
  end
  
  describe "parsing track data" do
    it "should parse swiped track data" do
      card_data = Swiper.parse('%B0123456789012345^DURDEN/TYLER Q^1409101000000000000000000000000?;0123456789012345=15021010000000000869?')
      card_data.track1.raw.should eq 'B0123456789012345^DURDEN/TYLER Q^1409101000000000000000000000000'
      card_data.track1.track_format.should eq 'B'
      card_data.track1.primary_account_number.should eq '0123456789012345'
      card_data.track1.cardholder_name.should eq 'TYLER Q DURDEN'
      card_data.track1.expiration_month.should eq '09'
      card_data.track1.expiration_year.should eq '14'
    end

    it "should trim whitespace around the name" do
      card_data = Swiper.parse('%B0123456789012345^DURDEN/TYLER Q                     ^1409101000000000000000000000000?;0123456789012345=15021010000000000869?')
      card_data.track1.raw.should eq 'B0123456789012345^DURDEN/TYLER Q                     ^1409101000000000000000000000000'
      card_data.track1.track_format.should eq 'B'
      card_data.track1.primary_account_number.should eq '0123456789012345'
      card_data.track1.cardholder_name.should eq 'TYLER Q DURDEN'
      card_data.track1.expiration_month.should eq '09'
      card_data.track1.expiration_year.should eq '14'
    end
  end
end