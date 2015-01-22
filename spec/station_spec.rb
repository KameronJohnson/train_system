require('spec_helper')

describe("#Station") do

  describe(".all") do
    it("starts off with no stations") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe(".find_station") do
    it("returns a station by its ID number") do
      test_station = Station.new({:name => "Pearl", :id => nil})
      test_station.save()
      test_station2 = Station.new({:name => "Belmont", :id => nil})
      test_station2.save()
      expect(Station.find_station(test_station2.id())).to(eq(test_station2))
    end
  end

  describe("#name") do
    it("tells you the station name") do
      station = Station.new({:name => "Belmont", :id => nil})
      expect(station.name()).to(eq("Belmont"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      station = Station.new({:name => "Belmont", :id => nil})
      station.save()
      expect(station.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save stations to the database") do
      station = Station.new({:name => "Belmont", :id => nil})
      station.save()
      expect(Station.all()).to(eq([station]))
    end
  end

  describe("#==") do
    it("is the same if it has the same name") do
      station1 = Station.new({:name => "Belmont", :id => nil})
      station2 = Station.new({:name => "Belmont", :id => nil})
      expect(station1).to(eq(station2))
    end
  end


end #end class
