# frozen_string_literal: true

class PatchFunny < Patch
  def call
    funny_sets = %w[uh ug uqc hho arena rep ust]
    each_card do |_name, printings|
      funny = printings.all? { |card| funny_sets.include?(card['set_code']) }

      next unless funny

      printings.each do |printing|
        printing['funny'] = true
      end
    end
  end
end
