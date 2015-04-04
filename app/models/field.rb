class Field < ActiveRecord::Base
  has_one :import
  has_many :row

  attr_accessor :type, :name, :minLen, :maxLen
end
