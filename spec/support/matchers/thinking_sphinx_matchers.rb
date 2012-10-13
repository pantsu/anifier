module ThinkingSphinxMatchers

  def self.append_features(group)
    group.send(:include, Helpers)
  end

  module Helpers
      def have_search_index_for(*args)
      ThinkingSphinxMatchers::HaveColumnMatcher.new(:fields, *args)
    end

    def have_search_attribute_for(*args)
      ThinkingSphinxMatchers::HaveColumnMatcher.new(:attributes, *args)
    end
  end

  class HaveColumnMatcher
    def initialize(subject, *args)
      options = args.extract_options!
      raise ArgumentError if args.empty?

      @subject  = subject
      @indexes  = Array(options[:in])
      @expected = args
    end

    def matches?(target)
      @target = target
      indexes = @target.sphinx_indexes
      indexes = indexes.select { |i| @indexes.include?(i.name) } unless @indexes.empty?
      return false if indexes.empty?

      indexes.all? do |i|
        i.send(@subject).any? { |thing| thing.columns.any? { |c| c.__path == @expected }}
      end
    end

    def failure_message
      "Expected #{@target} to have a column #{@expected.join('.')} in " \
      "#{@subject} of #{@indexes.empty? ? 'all' : @indexes.inspect} indexes, " \
      "but it did not"
    end

    def negative_failure_message
      "Expected #{@target} NOT to have a column #{@expected.join('.')} in " \
      "#{@subject} of #{@indexes.empty? ? 'all' : @indexes.inspect} indexes, " \
      "but it did"
    end

  end
end