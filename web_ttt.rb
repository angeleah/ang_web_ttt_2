require "sinatra"
require "datamapper"

#DataMapper::setup(:default, "sqlite3://#{Dir.pwd/web_ttt.rb}")

# class WebBoard
#   include DataMapper::Resource
#   
#   property :id, Serial
#   property :s0, String
#   property :s1, String
#   property :s2, String
#   property :s3, String
#   property :s4, String
#   property :s5, String
#   property :s6, String
#   property :s7, String
#   property :s8, String
# end

get '/' do
 erb :index
end

post '/' do
  params[:player_1_type],
  params[:player_1_mark],
  params[:player_2_type],
  params[:player_2_mark],
end


  