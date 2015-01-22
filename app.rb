require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/line")
require("./lib/station")
require("pg")

DB = PG.connect({:dbname => "train"})

get('/') do
  @lines = Line.all()
  erb(:index)
end

post("/stations") do
  station_name = params.fetch("station_name")
  line_id = params.fetch("line_id").to_i()
  # due_date = params.fetch("due_date")
  station = Station.new({:name => name, :line_id => line_id,}) #:due_date => due_date})
  station.save()
  @line = Line.find_line(line_id)
  erb(:station)
end

post("/line") do
  color = params.fetch("color")
  line = Line.new({:color => color, :id => nil})
  line.save()
  @lines = Line.all()
  erb(:index)
end


get("/line/:id") do
  @line = Line.find_line(params.fetch("id").to_i())
  erb(:line)
end
