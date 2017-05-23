class AppHospitalImportJob < ApplicationJob
  queue_as :default

  include QyUtil::GetFromHttp

  def perform(url, key_map={})
    hash_list = get url
    AppHospital.import_from_hash_list hash_list, key_map
  end

  after_perform do
    puts 'Task to import app hospitals completed'
  end
end
