module QuoteMe

  module FieldSet

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def field(name, &block)
          if block_given?
            class_fields << {name: name, block: block}
          else
            class_fields << {name: name, block: nil }
          end
        end

        def class_fields
           @__class_fields__ ||= []
        end

      end

      def initialize(params={})
         @data = Hashie::Mash.new(params)
         after_initialize
      end

      def after_initialize;end

      def attributes
        @attributes ||= setup_attributes
      end

      def fields
        self.class.class_fields.collect {|f| f.values}.flatten.reject {|v| v == nil}
      end

      def setup_attributes
        FieldSet.new(data, self.class.class_fields)
      end

      def method_missing(method,*a,&b)
        if self.class.class_fields.map {|f| f[:name] }.include?(method)
          attributes.send(method,*a,&b)
        else
          super
        end
      end

      def respond_to?(method)
        self.class.class_fields.map {|f| f[:name] }.include?(method) || super
      end

      private

      attr_reader :data

      class FieldSet

        def initialize(data, fields)
          check_data(data,fields)
          fields.each do |field|
            if field[:block]
              define_singleton_method(field[:name]) { field[:block].call(data[field[:name]]) }
            else
              define_singleton_method(field[:name]) { data[field[:name]]}
              define_singleton_method("#{field[:name]}=") { |v| data[field[:name]] = v }
            end
          end
        end

        def check_data(data,fields)
          f = fields.collect {|f| f.keys}.flatten.reject {|v| v == :block}
          d = data.keys.collect {|d| d.to_sym }
        end
      end

    end

end