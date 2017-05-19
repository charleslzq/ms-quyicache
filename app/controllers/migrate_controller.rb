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
    AppHospital.delete_all
    app_hospital_list.each {|appHospital|
      # puts appHospital
      AppHospital.create appHospital
    }
    puts 'Sync Hospital(s) Completed'
  end

  def import_medicine_shops
    medicine_shop_list = get 'medicineShop'
    puts "Get #{medicine_shop_list.length} Shops from original data source"
    MedicineShop.delete_all
    medicine_shop_list.each {|medicineShop|
      # puts medicineShop
      MedicineShop.create(shopId: medicineShop['medId'], shopName: medicineShop['medName'])
    }
    puts 'Sync Shop(s) Completed'
  end

  def import_dict_code
    dict_codes = get 'dictCode'
    puts "Get #{dict_codes.length} DictCodes from original data source"
    DictCode.delete_all
    dict_codes.each {|dictCode|
      puts dictCode
      DictCode.create(typeId: dictCode['dictTypeId'], codeId: dictCode['dictCodeId'],
                      codeName: dictCode['dictCodeName'], codeStatus: dictCode['dictCodeStatus'],
                      lastUpdateUser: dictCode['lastUpdateUser'], codeSeq: dictCode['dictCodeSeq'],
                      lastUpdateTime: dictCode['lastUpdateTime'])
    }
    puts 'Sync DictCode(s) Completed'
  end
end
