# frozen_string_literal: true

require "spec_helper"
require "jekyll"
require_relative "../../../lib/jekyll/koziolekweb/deorphanter"

RSpec.describe Koziolekweb::Deorphanter do
  describe ".replace_single_letter_spaces" do
    it "zamienia spację po jednoliterowym słowie na niełamiącą" do
      input = "To jest z a b c test"
      expected = "To jest z&nbsp;a&nbsp;b&nbsp;c&nbsp;test"
      result = described_class.replace_single_letter_spaces(input)
      expect(result).to eq(expected)
    end

    it "nie zmienia tekstu bez jednoliterowych słów" do
      input = "To nie jest test"
      result = described_class.replace_single_letter_spaces(input)
      expect(result).to eq("To nie jest test")
    end

    it "zwraca pusty string, jeśli podany pusty string" do
      expect(described_class.replace_single_letter_spaces("")).to eq("")
    end

    it "zwraca argument bez zmian, jeśli nie jest stringiem" do
      expect(described_class.replace_single_letter_spaces(nil)).to be_nil
      expect(described_class.replace_single_letter_spaces(123)).to eq(123)
    end

    it "pomija pojedyncze litery wewnątrz bloków kodu markdown" do
      input = <<~MARKDOWN
        To jest normalny tekst z literą a.
        ```ruby
        def test
          a = 5
          return a + b
        end
        ```
        Kolejny akapit z literą o.
      MARKDOWN

      expected = <<~MARKDOWN
        To jest normalny tekst z&nbsp;literą a.
        ```ruby
        def test
          a = 5
          return a + b
        end
        ```
        Kolejny akapit z&nbsp;literą o.
      MARKDOWN

      result = described_class.replace_single_letter_spaces(input)
      expect(result).to eq(expected)
    end

  end

  describe ".apply_hook_to" do
    let(:doc) { double("Jekyll::Page", content: "A i o test") }

    it "modyfikuje content w obiekcie Jekylla" do
      allow(doc).to receive(:content=)
      described_class.apply_hook_to(doc)
      expect(doc).to have_received(:content=).with("A&nbsp;i&nbsp;o&nbsp;test")
    end
  end
end
