require 'sinatra'
require 'sinatra/reloader'
require 'csv'

get '/' do
    erb :index
end

get '/vote' do
    @name = params[:name]
    @pro = params[:pro]
    
    CSV.open("vote.csv", "a+") do |csv|
        csv << [@name, @pro]
    end
    
    erb :vote
end

get '/result' do
    
    @yes = 0
    @total = 0# 몇 명이 투표했는지 알아보기 위해(반복문이 몇번 돌았는지 계산)
    CSV.foreach("vote.csv") do |row|
        @yes += row[1].to_i #v[1]이 문자로 인식
        @total += 1
    end
    
    @cheers = []
    CSV.foreach("cheer.csv") do |row|
        @cheers << row
    end
    
    erb :result
end

get '/cheer' do
   #  사용자로부터 '이름'과 '응원의 말'을 입력 받아서
   #  cheer.csv에 저장한 후,
   #  /result 페이지에 응원의 내용을 보여준다.
   
   erb :cheer
end

get '/write' do
    @name = params[:name]
    @msg = params[:msg]
    
    CSV.open("cheer.csv", "a+") do |csv|
        csv << [@name, @msg]
    end
        
    erb :write
end

get '/hello'do
    erb :hello

end