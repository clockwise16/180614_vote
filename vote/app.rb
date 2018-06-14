require 'sinatra'

get '/' do
    erb :index
end

get '/register' do
    @name=params[:name]
    File.open("list.txt","a+") do |f|
        f.write("#{@name}\n")
    end
    erb :register
end

get '/vote' do
    erb :vote
end

get '/voted' do
    @pick=params[:girls]
    @girls ={
        "sm" => "소미",
        "sj" => "세정",
        "kk" => "결경",
        "cy" => "채연",
        "ch" => "청하",
        "yj" => "유정",
        "ny" => "나영"
    }
    File.open("vote.txt","a+") do |f|
        f.write("#{@pick}\n")
    end
    
    #File.open통해서 vote.txt 파일에 투표 결과들을 저장합니다.
    #vote.txt 파일은
    # sm
    # sj ... 쭉 이어지게
    
    erb :voted
end

get '/result' do
    @result = {
        "sm" => 0,
        "sj" => 0,
        "kk" => 0,
        "cy" => 0,
        "ch" => 0,
        "yj" => 0,
        "ny" => 0
    }
    
    File.open("vote.txt","r") do |f|
        f.each_line do |l|
            @result[l.chomp] +=1
        end
    end
    
    erb :result
end