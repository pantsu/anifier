module ActiveRecordExt
  extend ActiveSupport::Concern

  module ClassMethods
    def key_attr_scope(*attributes)
      attributes.each do |attr|
        scope "for_#{attr}", ->(value){ where("#{attr}_id" => value.is_a?(attr.to_s.classify.constantize) ? value.id : value) }
      end
    end
  end
end