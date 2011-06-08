class MacMini < Tower
  def initialize window
    super window

    @range = 60.0
    @projectile_colour = Gosu::fuchsia
    @damage = 10
    @firing_speed = 1
    @hindrance = :slow
    @cost = 25
  end
end