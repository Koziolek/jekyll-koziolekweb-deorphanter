# frozen_string_literal: true

require "jekyll"
require_relative "jekyll/koziolekweb/deorphanter"

Jekyll::Hooks.register [:pages, :posts, :documents], :pre_render do |doc|
  Koziolekweb::Deorphanter.apply_hook_to(doc)
end
