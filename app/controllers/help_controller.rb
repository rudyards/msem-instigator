# frozen_string_literal: true

class HelpController < ApplicationController
  def syntax
    @title = 'Syntax'
  end

  def contact
    @title = 'Contact'
  end

  def rules
    @title = 'Rules'
  end
end
