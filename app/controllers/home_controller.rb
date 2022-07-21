# Frozen string literal: true
require 'net/http'


class HomeController < ApplicationController
    def index
        url = "https://api.openweathermap.org/data/2.5/weather?lat=53.2707&lon=-9.0568&appid=8ebb03f562489754ec09097dd62234e6&units=metric"
        uri = URI(url)
        res = Net::HTTP.get_response(uri)
        @data = JSON.parse(res.body)
    end
end
