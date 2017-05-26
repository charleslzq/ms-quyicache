class CacheController < ApplicationController
  class_attribute :data_list

  before_action :init

  def get_by_type_id
    type = params[:typeId]
    result = Rails.cache.fetch "dictionary_code/typeId/#{type}"
    respond_to do |format|
      format.json { render json: result}
    end
  end

  def get_by_code_id
    code_id = params[:id]
    type_id = params[:typeId]
    result = Rails.cache.fetch "dictionary_code/codeId/#{code_id}&&#{type_id}"
    respond_to do |format|
      format.json { render json: result}
    end
  end

  def refresh
    self.data_list = fetch_data
    self.data_list.group_by{|data| data.typeId}.each {|type, code_list|
      Rails.cache.write("dictionary_code/typeId/#{type}", code_list.index_by(&:codeId))
    }
    self.data_list.each {|data| Rails.cache.write "dictionary_code/codeId/#{data.codeId}&&#{data.typeId}", data}
  end

  def fetch_data
    data_list = []
    data_list.concat AppHospital.all.map{|hospital|DictionaryCode.from_app_hospital hospital}
    data_list.concat MedicineShop.all.map{|shop|DictionaryCode.from_medicine_shop shop}
    data_list.concat DictCode.all.map{|code|DictionaryCode.from_dict_code code}
    data_list
  end

  private
  def init
    if data_list.nil? or data_list.empty?
      refresh
    end
  end
end

class DictionaryCode
  attr_accessor :typeId, :codeId, :codeName, :codeStatus, :lastUpdateUser, :lastUpdateTime, :codeSeq

  def self.from_app_hospital(hospital)
    dictionary_code = DictionaryCode.new
    dictionary_code.codeId = hospital.hospitalId
    dictionary_code.codeName = hospital.hospitalName
    dictionary_code.typeId = '0007'
    dictionary_code
  end

  def self.from_medicine_shop(shop)
    dictionary_code = DictionaryCode.new
    dictionary_code.codeId = shop.shopId
    dictionary_code.codeName = shop.shopName
    dictionary_code.typeId = '0007'
    dictionary_code
  end

  def self.from_dict_code(code)
    dictionary_code = DictionaryCode.new
    dictionary_code.codeId = code.codeId
    dictionary_code.codeName = code.codeName
    dictionary_code.typeId = code.typeId
    dictionary_code.codeSeq = code.codeSeq
    dictionary_code.codeStatus = code.codeStatus
    dictionary_code.lastUpdateTime = code.lastUpdateTime
    dictionary_code.lastUpdateUser = code.lastUpdateUser
    dictionary_code
  end
end
