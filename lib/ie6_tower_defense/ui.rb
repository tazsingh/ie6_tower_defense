class UI
  attr_accessor :apple_crack
  attr_reader :level

  def initialize window
    @window = window
    @towers = %w[IMac MacBookPro MacMini MacPro].map do |t|
      Object.const_get(t).new @window
    end

    @grid_size = @towers.first.icon.width / 4

    @text = Gosu::Font.new @window, "Helvetica Neue", 20

    @ghost = nil
    @icons_start_y = @window.height - @towers.first.icon.height - 35

    @grid = Grid.new @window

    @bug_classes = [AlphaTransparency, FloatingElement, HoverState, RoundedCorner]

    @bugs_drawn = []

    @level = 0
    next_level

    @apple_crack = 100
  end

  def update
    if @window.button_down? Gosu::Button::MsLeft
      if @ghost.nil? and @window.mouse_y >= @icons_start_y and
              @window.mouse_y < @icons_start_y + @towers.first.icon.height and @window.mouse_x >= 10 and
              @window.mouse_x < @towers.first.icon.width * @towers.size + 10
        index = 0
        while @window.mouse_x > @towers.first.icon.width * (index + 1) + 10
          index += 1
        end

        @ghost = @towers[index].clone
      end
    else
      @ghost = nil
    end

    if @since_last_drawn_bug <= 0
      @since_last_drawn_bug = 50

      @bugs_drawn << @bugs.pop unless @bugs.length == 0
    end

    @grid.placed_towers.each {|t| t.update @bugs_drawn }
    @bugs_drawn.each {|b| b.update }

    @since_last_drawn_bug = @since_last_drawn_bug - 1
  end

  def remove_bug bug
    @bugs_drawn.delete bug

    next_level if @bugs_drawn.length == 0 && @bugs.length == 0
  end

  def place_tower
    @grid.place_tower_on_tile @ghost if @ghost
  end

  def draw
    @text.draw "Apple Crack  #{@apple_crack}", 300, @window.height - 55, ZOrder::UI, 1.5, 1.5
    @text.draw "Level  #{@level}", 650, @window.height - 55, ZOrder::UI, 1.5, 1.5

    @towers.each_with_index do |tower, index|
      tower.icon.draw index * tower.icon.width + 10, @icons_start_y, ZOrder::UI
      @text.draw tower.cost, index * tower.icon.width + 10 + tower.icon.width / 2 - @text.text_width(tower.cost) / 2,
                 @icons_start_y + tower.icon.height + 5, ZOrder::UI
    end

    if @ghost
      @ghost.icon.draw @window.mouse_x - @ghost.icon.width / 2, @window.mouse_y - @ghost.icon.height / 2,
                       ZOrder::Ghost

      @grid.highlight_tile
    end

#    @text.draw @grid.waypoints.map {|w| w.join(',') }.join(' | '), 10, 10, ZOrder::UI, 1, 1, Gosu::white

#    @grid.waypoints.each do |w|
#      @window.draw_quad w.first * @grid.tile_size, w.last * @grid.tile_size, Gosu::red,
#                        w.first * @grid.tile_size + @grid.tile_size, w.last * @grid.tile_size, Gosu::red,
#                        w.first * @grid.tile_size + @grid.tile_size, w.last * @grid.tile_size + @grid.tile_size, Gosu::red,
#                        w.first* @grid.tile_size, w.last * @grid.tile_size + @grid.tile_size, Gosu::red,
#                        ZOrder::UI
#    end

    @bugs_drawn.each {|b| b.draw }
    @grid.draw
  end

  private
  def next_level
    @level += 1
    @since_last_drawn_bug = 1000
    @bugs = (0..10).to_a.map { @bug_classes[rand(@bug_classes.length)].new @window, self, @grid }
  end
end