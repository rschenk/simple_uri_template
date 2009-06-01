require 'uri'

class SimpleURITemplate
  attr_accessor :template
  
  def initialize(template)
    @template = template
  end
  
  def expand(values)
    @template.gsub(/\{(.*?)\}/) { URI.encode( (values[$1] || values[$1.to_sym] || '').to_s ) rescue '' }
  end
end