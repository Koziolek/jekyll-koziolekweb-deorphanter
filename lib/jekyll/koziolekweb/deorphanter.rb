# frozen_string_literal: true

require_relative "deorphanter/version"

module Koziolekweb
  module Deorphanter

    SINGLE_LETTER = /\b([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\-–])\b(?:\s|$)/
    REPLACE = '\1&nbsp;'
    BLOCK_REGEX = /```.*?```/m.freeze

    # Metoda zastępująca pojedyncze litery przekształcone w `&nbsp;`
    def self.replace_single_letter_spaces(content)
      return content unless content && content.is_a?(String)

      chunks = []
      # Podział treści na części (wewnątrz bloków kodu i poza nimi)
      content.split(BLOCK_REGEX).each_with_index do |chunk, index|
        chunk = chunk.gsub(SINGLE_LETTER, REPLACE)
        chunks << chunk
      end

      # Wstawianie nieruszonych bloków kodu z powrotem na swoje miejsca
      content.scan(BLOCK_REGEX).each_with_index do |code_block, i|
        chunks.insert(2 * i + 1, code_block)
      end

      chunks.join
    end



    def self.apply_hook_to(document)
      document.content = replace_single_letter_spaces(document.content)
    end
  end
end
