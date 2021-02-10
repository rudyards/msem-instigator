# frozen_string_literal: true

class ConditionColorExpr < ConditionSimple
  def initialize(a, op, b)
    @a = a.downcase
    @op = op
    @b = (b.downcase.chars & %w[w u b r g]).to_set
  end

  def match?(card)
    a = if @a == 'c'
          card.colors.chars.to_set
        else
          card.color_identity.chars.to_set
        end

    case @op
    when '='
      a == @b
    when '>='
      a >= @b
    when '>'
      a > @b
    when '<='
      a <= @b
    when '<'
      a < @b
    else
      raise "Expr comparison parse error: #{@op}"
    end
  end

  def to_s
    "#{@a}#{@op}#{(%w[w u b r g] & @b.to_a).join}"
  end
end
