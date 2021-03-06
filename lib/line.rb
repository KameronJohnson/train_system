class Line
  attr_reader(:color, :id)

  define_method(:initialize)  do |attributes|
    @color = attributes.fetch(:color)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM line;")
    lines = []
    returned_lines.each() do |line_attributes|
      color = line_attributes.fetch("color")
      id = line_attributes.fetch("id").to_i()
      lines.push(Line.new({:color => color, :id => id}))
    end
    lines
  end

  define_singleton_method(:find_line) do |id|
    found_line = nil
    Line.all().each() do |line_parameter|
      if line_parameter.id().==(id)
        found_line = line_parameter
      end
    end
    found_line
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO line (color) VALUES ('#{@color}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_line|
    self.color().==(another_line.color()).&(self.id().==(another_line.id()))
  end

  # define_method(:station_id)

end #end class
