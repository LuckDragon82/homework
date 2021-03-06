class Company < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :parent_child_companies, foreign_key: :parent_id
  has_one :inverse_parent_child_companies, class_name: 'ParentChildCompany', foreign_key: :child_id
  has_many :children, through: :parent_child_companies
  has_one :parent, through: :inverse_parent_child_companies


  def grant_user_role(user, role)
    membership = self.memberships.where(user: user).first
    membership ? membership.update(role: role) : self.memberships.create(user: user, role: role)
  end

  def role_for_user(user)
    self.memberships.where(user: user).first.try(:role) || (self.parent.present? ? self.parent.role_for_user(user) : nil)
  end

  def create_child_company
    (self.number_of_parents < 2) ? self.children.create : nil
  end

  def number_of_parents
    self.parent.present? ? self.parent.number_of_parents + 1 : 0
  end
end
