module Madlib
  TOKEN_REGEXP = /\(\((.*?)\)\)/

  class Game
    attr_accessor :template, :values
    attr_reader :tokens, :tokenized_template
    def initialize(template)
      self.template = template
      @tokens = []
      @tokenized_template = []
      @values = {}
    end
    
    def play
      self.tokenize
      @tokens.each do |token|
        puts "Enter a #{token.to_s}"
        @values[token] = gets.chomp
      end
      self.to_s
    end

    def tokenize
      @tokenized_template = [template]
      matched_token = true

      while matched_token && !(@tokenized_template[-1].is_a?(Symbol))
        matched_token = @tokenized_template[-1].match TOKEN_REGEXP
        
        if matched_token
          token = matched_token.captures[0].to_sym
          @tokens << token
          @tokenized_template = @tokenized_template[0..-2]
          @tokenized_template += [matched_token.pre_match] unless matched_token.pre_match.empty?
          @tokenized_template += [token]
          @tokenized_template += [matched_token.post_match] unless matched_token.post_match.empty?
        end
      end
    end

    def to_s
      @tokenized_template.map {|s| s.is_a?(Symbol) ? @values[s] : s}.join('')
    end
  end
end
