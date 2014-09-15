require 'sax-machine/handlers/sax_abstract_handler'
require 'oga'

module SAXMachine
  class SAXOgaHandler < Oga::XML::PullParser
    include SAXAbstractHandler

    def initialize(document, data, on_error, _)
      super(data)

      _initialize(document, on_error, _)
    end

    def on_text(text)
      _characters(text)

      return
    end

    def on_cdata(text)
      _characters(text)

      return
    end

    def on_element(*args)
      super

      _start_element(@node.name, @node.attributes.map { |a| [a.name, a.value] })

      return
    end

    def after_element(*args)
      element = nesting.pop

      _end_element(element)

      return
    end

    def on_error(type, value, stack)
      _error("#{type} #{value} #{stack}")

      return
    end
  end
end
