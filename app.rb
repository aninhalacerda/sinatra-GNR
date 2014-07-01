require 'sinatra'
require 'slim'
require 'data_mapper'

# conexão com o banco de dados SQLite
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Aposta
  include DataMapper::Resource
  property :id,           Serial
  property :nome,         String, :required => true
  property :gols_time1,  Integer, :required => true
  property :gols_time2,  Integer, :required => true
  property :completed_at, DateTime
end
# deve ser chamado depois de todos os modelos
DataMapper.finalize

get '/' do  
  slim :index  
end 

post '/' do
	# Salva um nova aposta no Banco e mapeia os campos do formulario para o modelo
	Aposta.create params[:aposta]
  "Boa sorte #{params[:aposta]["nome"]}!"
end

get '/apostas' do
	@apostas = Aposta.all
  slim :apostas
end