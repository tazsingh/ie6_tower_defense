class IMac < Tower
  def initialize window
    super window

    @range = 80.0
    @projectile_colour = Gosu::red
    @damage = 20
    @firing_speed = 1.5
    @cost = 15
  end
end