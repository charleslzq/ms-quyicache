class CreateAppHospitals < ActiveRecord::Migration[5.1]
  def change
    create_table :app_hospitals do |t|
      t.string :hospitalId
      t.string :hospitalName

      t.timestamps
    end
  end
end
