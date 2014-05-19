class Membership < ActiveRecord::Base
  #self.primary_key = [:company_id, :user_id]
  belongs_to :company
  belongs_to :user
  validates :role, inclusion: {in: %w(admin user denied)}
  validates :company, uniqueness: {scope: :user_id}
end
