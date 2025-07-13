# frozen_string_literal: true

require_relative "deorphanter/version"

module Koziolekweb
  module Deorphanter
    def self.replace_single_letter_spaces(content)
      return content unless content && content.is_a?(String)
      content.gsub(/\b([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\-–])\b(?:\s|$)/, '\1&nbsp;')
    end

    def self.apply_hook_to(document)
      document.content = replace_single_letter_spaces(document.content)
    end
  end
end
