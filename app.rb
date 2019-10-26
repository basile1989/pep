require "json"
require "rest-client"

require "sinatra"
require "sinatra/link_header"
require "sinatra/reloader" if development?

enable :static



get "/" do
  token = "ee8c8e389b5b4399825e49e19b9ff410"
  headers = { "X-Auth-Token" => "#{token}" }
  url = "http://api.football-data.org/v2/competitions/2015/matches"
  response = RestClient.get(url, headers)
  payload = JSON.parse(response.body)
  @currentMatchday = payload["matches"][0]["season"]["currentMatchday"]

  url = "http://api.football-data.org/v2/competitions/2015/matches?matchday=#{@currentMatchday}"
  response = RestClient.get(url, headers)
  payload = JSON.parse(response.body)

  @matches = payload["matches"]

  url = "http://api.football-data.org/v2/competitions/2015/teams"
  response = RestClient.get(url, headers)
  payload = JSON.parse(response.body)

  @teams = payload["teams"]

  erb :index
end
