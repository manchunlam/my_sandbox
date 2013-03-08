class Field < ActiveRecord::Base
  attr_accessible :instruction, :label, :comments_attributes

  has_many :comments
  
  accepts_nested_attributes_for :comments, :allow_destroy => true
end
