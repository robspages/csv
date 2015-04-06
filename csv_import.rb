require 'rubygems'
require 'CSV'

class Field
  attr_accessor :name
  attr_accessor :type
  attr_accessor :minLen
  attr_accessor :maxLen
  attr_accessor :val
end

class ImportFile
  attr_accessor :headerrow
  attr_accessor :rows
  attr_accessor :fields

  def addField(name,type,min=0,max=1000)
    f = Field.new
    f.name = name
    f.type = type
    f.minLen = min
    f.maxLen = max
    @fields = @fields || []
    @fields << f
  end

  def addLiteralField(name,type,val)
    f = Field.new
    f.name = name
    f.type = type
    f.minLen = 0
    f.maxLen = 1
    f.val = val
    @fields = @fields || []
    @fields << f
  end

  def setHeaderrow
    @headerrow = @headerrow || []
    @fields.each do |field|
      @headerrow << field.name
    end
  end

  def generate_file(filename, rowCount)
    i = 0
    @rows = @rows || []
    while i < rowCount
      @rows << makeARow
      i += 1
    end
    outputFile(filename)
  end

  def makeARow
    row = []
    @fields.each do |field|
      case field.type
      when "string"
        row << makeAString
      when "text"
        row << makeASentence
      when "integer"
        row << makeANumber(field.minLen, field.maxLen)
      when "literal"
        row << field.val
      else
        row << "unparseable"
      end
    end
    row
  end

  def makeAString
    words = ["Lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit", "Maecenas", "egestas", "rhoncus", "vehicula", "Vestibulum", "tincidunt", "nisl", "sit", "amet", "dignissim", "dignissim", "Quisque", "eget", "mattis", "sem", "ut", "convallis", "lorem", "Vivamus", "pharetra", "elit", "quis", "convallis", "lobortis", "Quisque", "dui", "massa", "dapibus", "vestibulum", "massa", "at", "sagittis", "varius", "justo", "Praesent", "sit", "amet", "porta", "lectus", "Ut", "ultricies", "orci", "at", "ipsum", "condimentum", "non", "vulputate", "nibh", "aliquet", "Vivamus", "eu", "efficitur", "libero", "In", "quis", "risus", "euismod", "cursus", "ligula", "non", "lacinia", "erat", "Nunc", "efficitur", "semper", "leo", "nec", "tempus", "diam", "vehicula", "et", "Interdum", "et", "malesuada", "fames", "ac", "ante", "ipsum", "primis", "in", "faucibus", "Pellentesque", "malesuada", "et", "velit", "et", "iaculis", "Aenean", "non", "egestas", "velit", "Duis"]
    words.sample
  end

  def makeASentence
    sentence = []
    i = 0
    r = rand(4..14)
    while i < r
      sentence << makeAString
      i += 1
    end
    sentence.join(" ")
  end

  def makeANumber(min, max)
    rand(min..max)
  end

  def makeADate(dString)

  end

  def outputFile(filename)
    CSV.open(filename, "w", :skip_blanks => true, :force_quotes =>true) do |csv|
      csv << @headerrow
      @rows.each do |row|
        csv << row
      end
    end
  end
end


i = ImportFile.new

i.addField("PogDBKey", "integer", 1000, 1002)
i.addLiteralField("Effective Campaign", "literal", "2015/04/01")
i.addLiteralField("Category", "literal", "Books")
i.addLiteralField("Title", "literal", "Tech Books")
i.addLiteralField("Subtitle", "literal", "8Ft 6Ft")
i.addField("Pog Segment",  "integer", 1000, 1002)
i.addField("Segment",  "integer", 1,5)
i.addField("Product DBKey",  "integer", 1, 1000)
i.addField("x",  "integer", 0, 288)
i.addField("y",  "integer", 0, 96)
i.addLiteralField("GS1Code", "literal", "11-0-000-NE")

i.setHeaderrow
i.generate_file("/Users/rallen/Desktop/sample.csv", 200)



