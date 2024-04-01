class CreateDislikes < ActiveRecord::Migration[7.1]
  def change
    create_table :dislikes do |t|

      t.timestamps
    end
  end
end
