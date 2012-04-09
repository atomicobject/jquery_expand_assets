require 'tilt'

module ExpandAssets
  class ExpandProcessor < Tilt::Template
    self.default_mime_type = 'application/javascript'

    class << self
      # A proc that is called to modify the template name used as the
      # JST key. The proc is passed the name as an argument and should
      # return the modified name (or unmodified) name.
      attr_accessor :name_filter
    end

    # By default, remove any leading templates/ in the name
    self.name_filter = lambda { |n| n.sub /^templates\//, '' }

    def prepare
      @namespace = self.class.default_namespace
    end

    def self.default_namespace
      'this.JST'
    end

    attr_reader :namespace

    def evaluate(scope, locals, &block)
      p "evaluating #{scope.logical_path.inspect}"
      p data
      # "function(){$(#{data.inspect}).expand();}"
      name = scope.logical_path
      name = self.class.name_filter.call(name)
      <<-JST
(function() {
  #{namespace} || (#{namespace} = {});
  var template = null;
  #{namespace}[#{name.inspect}] = function(directive) { 
    template = template || $(#{data.inspect});
    return template.expand(directive);
  };
}).call(this);
      JST
    end

    private
    def indent(string)
      string.gsub(/$(.)/m, "\\1  ").strip.inspect
    end
  end
end
