require 'net/http'

class MigrateController < ApplicationController
  @@base_url = 'http://localhost:8099/export?type='.freeze

  def import
    import_app_hospital
    import_medicine_shops
    import_dict_code
  end

  private
  def get(type)
    url = @@base_url + type
    JSON.parse Net::HTTP.get(URI(url))
  end

  def import_app_hospital
    app_hospital_list = get 'appHospital'
    puts "Get #{app_hospital_list.length} hospital(s) from original data source"
    AppHospital.import_from_hash_list app_hospital_list
    puts 'Sync Hospital(s) Completed'
  end

  def import_medicine_shops
    medicine_shop_list = get 'medicineShop'
    puts "Get #{medicine_shop_list.length} Shops from original data source"
    MedicineShop.import_from_hash_list medicine_shop_list, {
        'medId': 'shopId',
        'medName': 'shopName'
    }
    puts 'Sync Shop(s) Completed'
  end

  def import_dict_code
    dict_codes = get 'dictCode'
    puts "Get #{dict_codes.length} DictCodes from original data source"
    dict_codes.each {|dictCode|
      puts dictCode
      DictCode.import_from_hash dictCode, {
          dictTypeId: 'typeId',
          dictCodeId: 'codeId',
          dictCodeName: 'codeName',
          dictCodeStatus: 'codeStatus',
          dictCodeSeq: 'codeSeq'
      }
    }
    puts 'Sync DictCode(s) Completed'
  end
end
