class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|

      t.string :name
      t.string :company
      t.text :description
      t.string :category  
      t.datetime :deadline
    end
  end
end
