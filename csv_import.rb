require "Rails"
require "CSV"

class ImportFile
  attr_accessor :headerrow
  attr_accessor :rows
  attr_accessor :fields

  def addField(name,type,min=0,max=1000)
    f = Field.new
    f[:name] = name
    f[:type] = type
    f[:minLen] = min
    f[:maxLen] = max
    f.save

    (self.fields ||= []) << f
  end

  def setHeaderrow(fields)
    fields.each do |field|
      (self.headerrow ||= []) << field.name
    end
  end

  def generate_file(filename, rowCount)
    i = 0
    self.fields = []
    while i < rowCount
      self.rows << makeARow(self.fields)
    end

    # write the file. See RubyScripts for examples
  end

  def makeARow(fields)
    fields.each do |field|
      case field.type
      when "string"
        row << makeAString
      when "text"
        row << makeASentence
      when "integer"
        row << makeANumber
      end
    end
    row
  end

  def makeAString
    words = ["skin", "request", "religion", "distribution", "jellyfish", "color", "hour", "stove", "glove", "pig", "committee", "coat", "fairies", "guide", "burst", "cats", "jump", "eggnog", "beds", "caption"]
    words.sample
  end

  def makeASentence
    sentence = []
    while i < [4..10].sample
      sentence << MakeAString
    end
    sentence.join(" ") + "."
  end

  def makeANumber(min, max)
    [min...max].sample
  end
end
