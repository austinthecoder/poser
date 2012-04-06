module Poser
  class Util

    class << self
      def first_available_class(*class_names)
        class_names.flatten!
        if class_name = class_names.shift
          constantize_string class_name
        end
      rescue NameError
        retry
      end

    private

      def constantize_string(camel_cased_word)
        if camel_cased_word.respond_to? :constantize
          camel_cased_word.constantize
        else
          names = camel_cased_word.split '::'
          names.shift if names.empty? || names.first.empty?

          names.inject(Object) do |constant, name|
            constant.const_get name, false
          end
        end
      end
    end

  end
end