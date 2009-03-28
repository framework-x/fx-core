require "rubygems"
require "rake"

unless :test.respond_to?(:to_proc)
  class Symbol
    # Turns the symbol into a simple proc, which is especially useful for enumerations. Examples:
    #
    #   # The same as people.collect { |p| p.name }
    #   people.collect(&:name)
    #
    #   # The same as people.select { |p| p.manager? }.collect { |p| p.salary }
    #   people.select(&:manager?).collect(&:salary)
    def to_proc
      Proc.new { |*args| args.shift.__send__(self, *args) }
    end
  end
end

class Symbol #:nodoc:
  def arrayize
    [self]
  end  
end

module HashExtension
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[key.to_sym || key] = value
      options
    end
  end

  # Destructively convert all keys to symbols.
  def symbolize_keys!
    self.replace(self.symbolize_keys)
  end

  def has_keys?(*expected_keys)
    expected_keys.all? { |key| has_key? key }
  end

  def keep(*keys)
    keys = flatten_if_array(keys)
    if respond_to?(:convert_key)
      reject { |key, value| !keys.collect { |k| convert_key(k) }.include?(key) }
    else
      reject { |key, value| !keys.include?(key) }
    end
  end

  def without(*keys)
    clone = self.dup
    keys = flatten_if_array(keys)
    keys.each { |key| clone.delete(key) }
    clone
  end

  def flatten_if_array(keys)
    keys.size == 1 && keys[0].is_a?(Array) ? keys[0] : keys
  end

  protected :flatten_if_array  
end

Hash.send(:include, HashExtension)

module ModuleExtension

  def equality_based_on(*variables)
    define_method "==" do |other|
      return true if other.equal?(self)
      return false unless other.instance_of?(self.class)      
      variables.all? do |variable|
        self.instance_variable_get("@#{variable}") == other.instance_variable_get("@#{variable}")
      end
    end

    define_method(:eql?) do |other|
      self == other
    end    
  end
  
  def hash_based_on(*variables)
    define_method(:hash) do
      result = self.instance_variable_get("@#{variables.first}").hash
      variables.each_with_index do |variable, index|
        next if index == 0 
        result = result ^ self.instance_variable_get("@#{variable}").hash
      end
      result
    end
  end
  
  def hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      data.symbolize_keys!
      attribute_names.each do |attribute_name|
        instance_variable_set "@#{attribute_name}", data[attribute_name]
      end
    end
  end
    
  def positional_initializer(*attribute_names, &block)
    define_method(:initialize) do |*args|
      attribute_names.each do |name|
        instance_variable_set "@#{name}", args.shift
      end
      instance_eval &block if block
    end
  end
  
end

Module.send :include, ModuleExtension


module ObjC

  class MethodParameter  
    attr_reader :type, :parameter_name, :variable_name
    
    equality_based_on :type, :parameter_name, :variable_name
    hash_based_on :type, :parameter_name, :variable_name
    
    hash_initializer :type, :parameter_name, :variable_name    
    
  end
end

module ObjC
  class MethodSignature
    
    attr_reader :method_name, :parameters
    
    equality_based_on :method_name, :parameters
    hash_based_on :method_name, :parameters
    
    def initialize(signature_string)
      @signature_string = signature_string.strip.sub(/\s*\{\s*.*$/,"")    
      @signature_string =~ /^\s*(\+|-)\s*\(.*?\)\s*(.*)/          
      @is_class_method = ($1 == "+") ? true : false 
      parameter_string = $2               
      parameters = parameter_string.split(/[:\(\)]/).inject([]) do |result, p|     
        if p.include?("*")
          result << p.strip
        elsif !p.strip.empty?
          result << p.strip.split(" ")
        end
        result
      end.flatten
      @method_name = parameters.first
      type, parameter_name = nil, nil
      
      @parameters = []
      if parameters.size > 1 
        parameters.each_with_index do |p, index|
          case(index % 3)
          when 0:
            parameter_name = p unless index == 0 # don't want to add the method name
          when 1:
            type = p
          when 2:
            @parameters << ObjC::MethodParameter.new(:type => type, :parameter_name => parameter_name, :variable_name => p)          
          end
        end
      end
    end                            
  
    def self.extract_methods(contents)
      methods = []
      contents.each_line do |line|
        if line =~ /^\s*\/\/\s*__end__/
          break
        end
        if line =~ /^\s*(\+|-)\s*\(/
          methods << MethodSignature.new(line)
        end
      end
      methods
    end    

    def class_method?
      @is_class_method 
    end
    
    def public_method?
      !@method_name.starts_with?("_")
    end                          
    
    def variable_names_in_signature_order
      @parameters.map(&:variable_name)
    end                                   
    
    def to_declaration
      @signature_string + ";"
    end
    
    def to_s
      @signature_string
    end                
    
    def to_selector_string
      return @method_name if @parameters.empty?
      @parameters.inject("") do |selector, parameter| 
        selector << (parameter.parameter_name ? parameter.parameter_name.to_s : @method_name)
        selector << ":" if parameter.variable_name
        selector
      end
    end
    
    def to_selector_string_with_scope
      "#{class_method? ? "+" : "-"} #{to_selector_string}"
    end
  end
end

module HExtractor
  def self.extract(contents)
    header = "// #{'*' * 40}\n// Generated from .m file\n// #{'*' * 40}\n\n"
    header << extract_imports(contents)
    header << "\n"
    header << extract_interface(contents)
    header << "\n"
    header.sub!("@end", ObjC::MethodSignature.extract_methods(contents).map(&:to_declaration).join("\n") + "\n@end")
    header
  end
  
  def self.extract_commented_interface_declaration(contents)
    contents.match(/\/\*\s*(.+?)\*\//m)[1]
  end
  
  def self.extract_imports(contents)
    interface_declaration = self.extract_commented_interface_declaration(contents)
    imports = []
    interface_declaration.each_line do |line|
      if line =~ /^\s*#import/
        imports << line
      end
    end
    imports.join
  end
  
  def self.extract_interface(contents)
    match = contents.match(/(@interface.+?@end)/m)      
    match ? match[0] : nil
  end

end


desc "generate header files"
task :h => "code:generate_headers"

namespace :code do
  desc "generates header files"
  task :generate_headers do
    m_files = Dir.glob(IPHONE_ROOT + "/source/**/*.m")
    m_files.each do |m_file|
      h_file = m_file.chomp(".m") + ".h"
      contents = File.read(m_file)
      if contents.match(/\/\*\s*(.+?)\*\//m) && contents.include?("@interface")
        if !File.exists?(h_file) || File.stat(m_file).mtime > File.stat(h_file).mtime
          new_contents = HExtractor.extract(contents)
          old_contents = File.exists?(h_file) ? File.read(h_file) : ""
          if old_contents != new_contents
            File.open(h_file, "w") do |f|
              f.write new_contents
            end
          end
        end
      end
    end
  end    
end
