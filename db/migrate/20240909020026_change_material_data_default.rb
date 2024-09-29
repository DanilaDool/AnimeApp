class ChangeMaterialDataDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :animes, :material_data, nil
  end
end
