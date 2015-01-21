# require('spec_helper')
require("rspec")
require("pg")
require("line")

DB = PG.connect({:dbname => 'train_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM line *;")
  end
end

describe("#Line") do

  describe(".all") do
    it("starts off with no lines") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#color") do
    it("tells you the line color") do
      line = Line.new({:color => "Blue", :id => nil})
      expect(line.color()).to(eq("Blue"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      line = Line.new({:color => "Blue", :id => nil})
      line.save()
      expect(line.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lines to the database") do
      line = Line.new({:color => "Blue", :id => nil})
      line.save()
      expect(Line.all()).to(eq([line]))
    end
  end

  describe("#==") do
    it("is the same if it has the same name") do
      line1 = Line.new({:color => "Blue", :id => nil})
      line2 = Line.new({:color => "Blue", :id => nil})
      expect(line1).to(eq(line2))
    end
  end


end #end class
