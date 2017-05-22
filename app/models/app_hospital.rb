class AppHospital < ImportableApplicationRecord
  self.primary_key='hospitalId'

  def import(app_hospital)
    self.create app_hospital
  end
end
