module QuoteMe

  module FindCollection

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def all
        Thread.current[plural_sym] ||= []
      end

      def delete_all
        Thread.current[plural_sym] = []
      end

      def <<(obj)
        self.all << obj unless self.all.map(&:hash).include?(obj.hash)
      end

      def name_from_constant
        path = self.to_s
        if i = path.rindex('::')
          path[(i+2)..-1].downcase
        else
          path.downcase
        end
      end

      def plural_name_from_constant
        name_from_constant+"s"
      end

      def plural_string
        plural_name_from_constant
      end

      def plural_sym
        plural_name_from_constant
      end

    end

    def after_initialize
      self.class << self
    end

    def hash
      Digest::SHA1.hexdigest(concat_field_values.flatten.join)
    end

    def concat_field_values
      fields.collect do |field|
        attributes.send(field)
      end
    end

  end

end