class CreateDictCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :dict_codes do |t|
      t.string :typeId
      t.string :codeId
      t.string :codeName
      t.string :codeStatus
      t.string :lastUpdateUser
      t.integer :codeSeq

      t.timestamps
    end
  end
end
