class CacheController < ApplicationController
  def getByTypeId
  end

  def getByCodeId
  end

  def refresh
  end

  private
  def init

  end
end

class DictionaryCode
  attr_accessor :typeId, :codeId, :codeName, :codeStatus, :lastUpdateUser, :lastUpdateTime, :codeSeq
end
