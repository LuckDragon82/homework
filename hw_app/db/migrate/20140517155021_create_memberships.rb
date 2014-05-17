class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships, id: false do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :role
    end
  end
end
