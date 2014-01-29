class Cell
  def initialize
    @alive = false
  end

  def alive?
    @alive
  end

  def live!
    @alive = true
  end

  def die!
    @alive = false
  end
end