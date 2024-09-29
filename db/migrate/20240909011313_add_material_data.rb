class AddMaterialData < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :material_data, :jsonb, default: {}
  end
end
