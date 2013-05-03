# Swiper

Swiper parses Track 1 data from a raw credit card swipe.  [Wikipedia Link](http://en.wikipedia.org/wiki/Magnetic_stripe_card)

## Install

Ruby

    gem install swiper

Bundler

    gem 'swiper'

## Use
    swiped_data = "%B0123456789012345^DURDEN/TYLER Q^1409101000000000000000000000000?;0123456789012345=15021010000000000869?"

    if Swiper.can_parse? swiped_data
      card_data = Swiper.parse(swiped_data)
    end
    
    puts card_data.track1.raw
    puts card_data.track1.track_format
    puts card_data.track1.primary_account_number
    puts card_data.track1.cardholder_name
    puts card_data.track1.expiration_month
    puts card_data.track1.expiration_year

## Coming soon

* Track2 parsing