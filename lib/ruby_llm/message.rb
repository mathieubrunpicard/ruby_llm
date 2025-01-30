# frozen_string_literal: true

module RubyLLM
  class Message
    VALID_ROLES = %i[system user assistant tool].freeze

    attr_reader :role, :content, :tool_calls, :tool_results, :token_usage, :model_id

    def initialize(role:, content: nil, tool_calls: nil, tool_results: nil, token_usage: nil, model_id: nil)
      @role = role.to_sym
      @content = content
      @tool_calls = tool_calls
      @tool_results = tool_results
      @token_usage = token_usage
      @model_id = model_id
      validate!
    end

    def to_h
      {
        role: role,
        content: content,
        tool_calls: tool_calls,
        tool_results: tool_results,
        token_usage: token_usage,
        model_id: model_id
      }.compact
    end

    private

    def validate!
      unless VALID_ROLES.include?(role)
        raise ArgumentError,
              "Invalid role: #{role}. Must be one of: #{VALID_ROLES.join(', ')}"
      end
      raise ArgumentError, 'Content cannot be nil' if content.nil?
      raise ArgumentError, 'Content cannot be empty' if content.empty?
    end
  end
end
