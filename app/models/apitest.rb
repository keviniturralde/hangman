# require 'uri'
# require 'net/http'
# require 'openssl'
# require 'pry'


# class Api

#     def call

# url = URI("https://wordsapiv1.p.rapidapi.com/words/?random=true")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# request = Net::HTTP::Get.new(url)
# request["x-rapidapi-host"] = 'wordsapiv1.p.rapidapi.com'
# request["x-rapidapi-key"] = '342629ac30msh0b8ebd82041977ap15f609jsnedc9324690ee'

# response = http.request(request)
# puts response.read_body

#     end

# end

# api = Api.new
# binding.pry