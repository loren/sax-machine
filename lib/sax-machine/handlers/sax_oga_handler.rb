require 'sax-machine/handlers/sax_abstract_handler'
require 'oga'

module SAXMachine
  class SAXOgaHandler
    include SAXAbstractHandler

    def initialize(*args)
      _initialize(*args)
      @node_names = []
    end

    def on_element(namespace, name, attrs)
      full_name = namespace ? [namespace, name].join(":") : name
      @node_names << full_name
      _start_element(full_name, attrs.map { |a| [a.name, a.value] })
    end

    def after_element(*args)
      _end_element(@node_names.pop)
    end

    def on_error(*args)
      _error(args.join(" "))
    end

    alias_method :on_text, :_characters
    alias_method :on_cdata, :_characters
    alias_method :error, :_error
  end
end
