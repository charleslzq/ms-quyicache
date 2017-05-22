class ImportableApplicationRecord < ApplicationRecord
  self.abstract_class = true

  include QyUtil::Import
end