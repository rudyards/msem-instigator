# frozen_string_literal: true

class ConditionBlock < Condition
  def initialize(*blocks)
    @blocks = blocks.map { |b| normalize_name(b) }
  end

  # For sets and blocks:
  # "in" is code for "Invasion", don't substring match "Innistrad" etc.
  # "Mirrodin" is name for "Mirrodin", don't substring match "Scars of Mirrodin"
  def search(db)
    merge_into_set matching_sets(db).map(&:printings)
  end

  def to_s
    "b:#{@blocks.map { |b| maybe_quote(b) }.join(',')}"
  end

  private

  def matching_sets(db)
    sets = Set[]
    @blocks.each do |block|
      db.sets.each do |_set_code, set|
        next unless set.block_code && set.block_name

        if db.blocks.include?(block)
          if (set.block_code == block) || (set.official_block_code == block) || (normalize_name(set.block_name) == block)
            sets << set
          end
        elsif normalize_name(set.block_name).include?(block)
          sets << set
        end
      end
    end
    sets
  end
end
