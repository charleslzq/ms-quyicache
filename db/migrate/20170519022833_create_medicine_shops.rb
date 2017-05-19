class CreateMedicineShops < ActiveRecord::Migration[5.1]
  def change
    create_table :medicine_shops do |t|
      t.string :shopId
      t.string :shopName

      t.timestamps
    end
  end
end
