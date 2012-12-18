class User < ActiveRecord::Base
  attr_accessible :name, :password
  has_many :orders, :dependent => :destroy
  validates :name , :uniqueness => true
end
