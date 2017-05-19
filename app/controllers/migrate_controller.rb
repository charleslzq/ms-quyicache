require 'net/http'

class MigrateController < ApplicationController
  @@base_url = 'http://localhost:8099/export?type='.freeze

  def import
    importAppHospital
    importMedicineShop
    importDictCode
  end

  private
  def get type
    url = @@base_url + type
    JSON.parse Net::HTTP.get(URI(url))
  end

  def importAppHospital
    appHospitalList = get 'appHospital'
    count = 0
    puts "Get #{appHospitalList.length} hospital(s) from original data source"
    appHospitalList.each {|appHospital|
      # puts appHospital
      AppHospital.create appHospital
      count += 1
    }
    puts "Insert #{count} Hospital(s)"
  end

  def importMedicineShop
    medicineShopList = get 'medicineShop'
    puts "Get #{medicineShopList.length} Shops from original data source"
    count = 0
    medicineShopList.each {|medicineShop|
      # puts medicineShop
      MedicineShop.create(shopId: medicineShop['medId'], shopName: medicineShop['medName'])
      count += 1
    }
    puts "Insert #{count} Shop(s)"
  end

  def importDictCode
    dictCodes = get 'dictCode'
    puts "Get #{dictCodes.length} DictCodes from original data source"
    count = 0
    dictCodes.each {|dictCode|
      puts dictCode
      DictCode.create(typeId: dictCode['dictTypeId'], codeId: dictCode['dictCodeId'],
                      codeName: dictCode['dictCodeName'], codeStatus: dictCode['dictCodeStatus'],
                      lastUpdateUser: dictCode['lastUpdateUser'], codeSeq: dictCode['dictCodeSeq'],
                      lastUpdateTime: dictCode['lastUpdateTime']
      )
      count += 1
    }
    puts "Insert #{count} DictCode(s)"
  end
end
