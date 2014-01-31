class Rule
  def toggle?(alive, live_neighbours)
    raise "live_neighbours must be in the [0..8] range" if live_neighbours < 0 || live_neighbours > 8

    if alive
      if live_neighbours < 2 || live_neighbours > 3
        true #kill it
      else
        false
      end
    else
      if live_neighbours == 3
        true #resuscitate
      else
        false
      end
    end
  end
end