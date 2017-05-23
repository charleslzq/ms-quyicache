module QyUtil


  module Import
    extend ActiveSupport::Concern

    module ClassMethods
      def update_or_create_by_hash(hash)
        if hash.include? self.primary_key
          target = self.find_or_initialize_by(id: hash[self.primary_key])
          target.update_attributes hash
        else
          self.create hash
        end
      end

      def import_from_hash(hash, key_map={})
        if key_map.nil? or key_map.empty?
          update_or_create_by_hash hash
        else
          result_hash = {}
          hash.entries.each_with_object(result_hash) { |(key, value), result|
            result[(key_map.include?(key.to_s.to_sym) ?
                key_map[key.to_s.to_sym].to_s.to_sym : key.to_s.to_sym)] = value
          }
          update_or_create_by_hash result_hash
        end
      end

      def import_from_hash_list(hash_list, key_map={})
        freeze_key_map = key_map.freeze
        hash_list.each { |hash|
          import_from_hash hash, freeze_key_map
        }
      end
    end
  end
end