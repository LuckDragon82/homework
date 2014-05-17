class CreateParentChildCompanies < ActiveRecord::Migration
  def change
    create_table :parent_child_companies, id: false do |t|
      t.integer :parent_id
      t.integer :child_id
    end
  end
end
