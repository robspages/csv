class Row < ActiveRecord::Base
  belongs_to :import
  has_many :field
end
