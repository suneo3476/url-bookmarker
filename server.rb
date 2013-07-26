require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'

if development?
	require 'sinatra/reloader'
end

DataMapper.setup(:default, 'sqlite3:db/diptych.db')
class Entries
	include DataMapper::Resource
	property :id, Serial
	property :url, String
	property :created_at, DateTime
	property :updated_at, DateTime
	DataMapper.auto_upgrade!
end

get '/' do
	@title = 'diptych - TOP'
	@entries = Entries.all
	haml :index
end

post '/add' do
	@entry = Entries.new :url => Sanitize.clean(params[:url])
	@entry.save
	redirect '/'
end

helpers do
	def add_schema(url)
		if url !~ /^https?/
			if url =~ /\/\//
				"http:#{url}"
			else
				"http://#{url}"
			end
		else
			url
		end
	end

	def shorten(str, max = 20)
		if str.length > max
			"#{str[0..max.to_i]}..."
		else
			str
		end
	end

	def timefmt(time)
		if time
			time.strftime("%Y-%m-%d %H:%M:%S")
		else
			''
		end
	end
end
