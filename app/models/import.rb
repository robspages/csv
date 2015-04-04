class Import < ActiveRecord::Base
  has_many :field,
           :through => :headerrow,
           :class_name => "Field",
           :source => :field
  has_many :rows

  def headerrow

  end


end
