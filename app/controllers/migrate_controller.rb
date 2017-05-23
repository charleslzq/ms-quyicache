class MigrateController < ApplicationController
  BASE_URL = "#{Rails.configuration.x.qy['cache']['url']}/export?type=".freeze

  def import
    self.send "import_#{params[:type]}"

    respond_to do |format|
      format.json { render json: {message: 'Import Jobs Submitted Successfully'}}
    end
  end

  private
  def import_app_hospital
    AppHospitalImportJob.perform_later BASE_URL + 'appHospital'
  end

  def import_medicine_shop
    MedicineShopImportJob.perform_later BASE_URL + 'medicineShop', {
        medId: 'shopId',
        medName: 'shopName'
    }.stringify_keys!
  end

  def import_dict_code
    DictCodeImportJob.perform_later BASE_URL + 'dictCode', {
        dictTypeId: 'typeId',
        dictCodeId: 'codeId',
        dictCodeName: 'codeName',
        dictCodeStatus: 'codeStatus',
        dictCodeSeq: 'codeSeq'
    }.stringify_keys!
  end
end
