Geocoder.configure do |config|

# set default units to kilometers:
  config.units = :km

# geocoding service request timeout, in seconds (default 3):
  config.timeout = 5
end