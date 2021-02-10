# frozen_string_literal: true

class ConditionOther < Condition
  def initialize(cond)
    @cond = cond
  end

  def search(db)
    result = Set[]
    @cond.search(db).each do |c|
      result.merge(c.others) if c.others
    end
    result
  end

  def metadata!(key, value)
    super
    @cond.metadata!(key, value)
  end

  def to_s
    "other:#{@cond}"
  end
end
