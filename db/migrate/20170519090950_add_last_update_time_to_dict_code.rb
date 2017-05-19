class AddLastUpdateTimeToDictCode < ActiveRecord::Migration[5.1]
  def change
    add_column :dict_codes, :lastUpdateTime, :string
  end
end
