class DataController < ApplicationController

  def list
    @list = self.send "#{params[:type]}"
    respond_to do |format|
      format.json { render json: @list}
    end
  end

  private
  def app_hospital
    AppHospital.all
  end

  def medicine_shop
    MedicineShop.all
  end

  def dict_code
    DictCode.all
  end
end
