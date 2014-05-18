class Company < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :parent_child_companies, foreign_key: :parent_id
  has_one :inverse_parent_child_companies, class_name: 'ParentChildCompany', foreign_key: :child_id
  has_many :children, through: :parent_child_companies
  has_one :parent, through: :inverse_parent_child_companies
end
