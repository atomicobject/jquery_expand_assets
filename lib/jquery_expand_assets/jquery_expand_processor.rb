require 'tilt'

module JqueryExpandAssets
  class JqueryExpandProcessor < Tilt::Template
    # implemented for the superclass's template method
    def prepare; end

    def evaluate(scope, locals, &block)
      name = scope.logical_path.sub(/^templates\//, '').sub(%r{/?_?([^/]*)$}, '/\1')
      <<-COFFEE
        this.JST ||= {}
        template = null
        html = """
               #{data}
               """
        this.JST[#{name.inspect}] = (directive) ->
          template ||= $(html)
          template.expand(directive).children()
      COFFEE
    end
  end
end
