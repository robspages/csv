class Headerrow < ActiveRecord::Base
 belongs_to :import
 has_many :field

 def addField name, type, min=0, max=255
  f = Field.new
  f.name = name
  f.type = type
  f.minLen = min
  f.maxLen = max

  self.field << f
  self.save

 end
end
