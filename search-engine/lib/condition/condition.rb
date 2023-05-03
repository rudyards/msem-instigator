# frozen_string_literal: true

class Condition
  def inspect
    to_s
  end

  # For simple conditions
  # cond.search(db) == db.select{|card| cond.match?(card)}
  # This is extremely relevant for query optimization
  def simple?
    false
  end

  # Save only what's needed, by default nothing
  def metadata!(key, value)
    @logger = value if key == :logger
  end

  def ==(other)
    # structural equality, subclass if you need something fancier
    self.class == other.class and
      instance_variables == other.instance_variables and
      instance_variables.all? { |ivar| instance_variable_get(ivar) == other.instance_variable_get(ivar) }
  end

  def hash
    [
      self.class,
      instance_variables.map { |ivar| [ivar, instance_variable_get(ivar)] }
    ].hash
  end

  def eql?(other)
    self == other
  end

  private

  def normalize_text(text)
    text.downcase.gsub(/[Ææ]/, 'ae').tr("Äàáâäèéêíõöúûu’\u2212", "Aaaaaeeeioouuu'-").strip
  end

  def normalize_name(name)
    normalize_text(name).split.join(' ')
  end

  def maybe_quote(text)
    case text
    when Date
      format('"%d.%d.%d"', text.year, text.month, text.day)
    when /\A[a-zA-Z0-9]+\z/
      text
    else
      text.inspect
    end
  end

  def warning(warn)
    @logger << warn
  end

  def timify_to_s(str)
    if @time
      "(time:#{maybe_quote(@time)} #{str})"
    else
      str
    end
  end

  def merge_into_set(subresults)
    result = Set[]
    subresults.each do |subresult|
      subresult.each do |item|
        result << item
      end
    end
    result
  end
end
