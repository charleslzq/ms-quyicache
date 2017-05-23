class MedicineShopImportJob < ApplicationJob
  queue_as :default

  include QyUtil::GetFromHttp

  def perform(url, key_map={})
    hash_list = get url
    MedicineShop.import_from_hash_list hash_list, key_map
  end

  after_perform do
    puts 'Task to import medicine shops completed'
  end
end
