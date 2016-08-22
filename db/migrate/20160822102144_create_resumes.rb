class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|

      t.timestamps null: false
      t.text :overview	
      t.text :links_to_projects
      t.text :education
      t.integer :user_id
    end
  end
end
