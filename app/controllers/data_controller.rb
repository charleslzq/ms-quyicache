class DataController < ApplicationController
  def appHospital
    @hospitals= AppHospital.all
    respond_to do |format|
      format.json { render json: @hospitals}
    end
  end

  def medicineShop
    @shops= MedicineShop.all
    respond_to do |format|
      format.json { render json: @shops}
    end
  end

  def dictCode
    @codes = DictCode.all
    respond_to do |format|
      format.json { render json: @codes}
    end
  end
end
