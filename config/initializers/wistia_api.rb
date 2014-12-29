require 'wistia'

Wistia.use_config!(:wistia => {
  :api => {
    :password => ENV['WISTIA_API_PASSWORD'],
    :format => 'json'
  }
})