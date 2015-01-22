class Station
  attr_reader(:name, :id)

  define_method(:initialize)  do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM station;")
    stations = []
    returned_stations.each() do |station_attributes|
      name = station_attributes.fetch("name")
      id = station_attributes.fetch("id").to_i()
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_singleton_method(:find_station) do |id|
    found_station = nil
    Station.all().each() do |station_parameter|
      if station_parameter.id().==(id)
        found_station = station_parameter
      end
    end
    found_station
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO station (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_station|
    self.name().==(another_station.name()).&(self.id().==(another_station.id()))
  end

end #end class
