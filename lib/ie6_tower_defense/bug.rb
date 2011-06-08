class Bug
  attr_reader :x, :y, :center_x, :center_y, :top, :right, :bottom, :left

  def initialize window, ui, grid
    @window = window
    @ui = ui
    @grid = grid

    @x = (@grid.waypoints.first.first * @grid.tile_size) + @grid.tile_size / 8
    @y = (@grid.waypoints.first.last * @grid.tile_size) + @grid.tile_size / 8

    @current_waypoint_index = 0
    next_waypoint

    @health = 50
    @speed = 1
    @colour = Gosu::red
    @hindered_for = 0
    @hindrance_type = nil
    @reward = 10
  end

  def take_damage damage, hindrance
    @health -= damage
    @hindered_for = 200 if @hindrance_type = hindrance

    if @health <= 0
      @ui.apple_crack += @reward
      @ui.remove_bug self
    end
  end

  def icon
    @icon ||= Gosu::Image.new @window, "../img/bugs/#{self.class.name}.png", true
  end

  def change_colour colour
    @colour = colour
  end

  def update
    if @current_waypoint.first != @next_waypoint.first
      if @current_waypoint.first > @next_waypoint.first &&
              left < @next_waypoint.first + @grid.tile_size / 4
        next_waypoint
      elsif @current_waypoint.first < @next_waypoint.first &&
              right > @next_waypoint.first + @grid.tile_size / 2 + @grid.tile_size / 4
        next_waypoint
      else
        @x += @current_waypoint.first > @next_waypoint.first ? -calculate_speed : calculate_speed
      end
    else
      if @current_waypoint.last > @next_waypoint.last &&
              top < @next_waypoint.last + @grid.tile_size / 4
        next_waypoint
      elsif @current_waypoint.last < @next_waypoint.last &&
              bottom > @next_waypoint.last + @grid.tile_size / 2 + @grid.tile_size / 4
        next_waypoint
      else
        @y += @current_waypoint.last > @next_waypoint.last ? -calculate_speed : calculate_speed
      end

    end

    @hindered_for -= 1 if @hindered_for > 0
  end

  def draw
    self.icon.draw @x, @y, ZOrder::Bug
#    @window.draw_quad @x, @y, @colour,
#                      @x + @grid.tile_size / 2 + @grid.tile_size / 4, @y, @colour,
#                      @x + @grid.tile_size / 2 + @grid.tile_size / 4, @y + @grid.tile_size / 2 + @grid.tile_size / 4, @colour,
#                      @x, @y + @grid.tile_size / 2 + @grid.tile_size / 4, @colour,
#                      ZOrder::Bug
  end

  def center_x
    @x + @grid.tile_size / 4 + @grid.tile_size / 8
  end

  def center_y
    @y + @grid.tile_size / 4 + @grid.tile_size / 8
  end

  def top
    @y
  end

  def right
    @x + @grid.tile_size / 2 + @grid.tile_size / 4
  end

  def bottom
    @y + @grid.tile_size / 2 + @grid.tile_size / 4
  end

  def left
    @x
  end

  private
  def next_waypoint
    @current_waypoint = @grid.waypoints[@current_waypoint_index].map {|c| c * @grid.tile_size }
    @next_waypoint = @grid.waypoints[@current_waypoint_index + 1].map {|c| c * @grid.tile_size }

    @current_waypoint_index += 1
    @x = @current_waypoint.first + @grid.tile_size / 8
    @y = @current_waypoint.last + @grid.tile_size / 8
  end

  def calculate_speed
    if @hindered_for > 0
      case @hindrance_type
        when :slow
          @speed * 0.5
        else
          @speed
      end
    else
      @speed
    end
  end
end

%w[alpha_transparency floating_element hover_state rounded_corner].each do |bug|
  require "./ie6_tower_defense/bugs/#{bug}"
end