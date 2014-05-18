class User < ActiveRecord::Base
  has_many :memberships
  has_many :companies, through: :memberships
end
