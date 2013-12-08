class String
  def to_boolean
    !!(self =~ /\A(true|t|yes|y|1)\z/i)
  end
end