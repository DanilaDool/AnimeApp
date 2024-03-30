class AddImgContentToEntry < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :img_content, :string
  end
end
