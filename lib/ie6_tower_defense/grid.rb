require './ie6_tower_defense/grid/tile'

class Grid
  attr_reader :waypoints, :tile_size, :placed_towers

  def initialize window
    @window = window

    @tile_size = 40

    @tiles = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
              [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1],
              [0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1],
              [0,1,0,0,0,1,1,1,1,1,1,1,0,0,1,0,0,0,0,1],
              [0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,1],
              [0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,1,1,1],
              [0,0,1,1,1,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0],
              [0,0,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0],
              [0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0],
              [0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0],
              [0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,0],
              [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0],
              [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0]]

    @waypoints = [[16,12],
                  [16,8],
                  [12,8],
                  [12,10],
                  [2,10],
                  [2,6],
                  [9,6],
                  [9,7],
                  [11,7],
                  [11,3],
                  [5,3],
                  [5,4],
                  [1,4],
                  [1,1],
                  [14,1],
                  [14,5],
                  [19,5],
                  [19,0]]

#    determine_waypoints

    @tiles = @tiles.each_with_index.map do |col, ci|
      col.each_with_index.map do |row, ri|
        Tile.new(@window, @tile_size, ri * @tile_size, ci * @tile_size, row == 0)
      end
    end

    @placed_towers = []
  end

  def place_tower_on_tile tower
    if row = @tiles[@window.mouse_y / @tile_size]
      tile = row[@window.mouse_x / @tile_size]
      if tile
        tile.place_tower tower
        @placed_towers << tower if tower.placed?
      end
    end
  end

  def highlight_tile
    if row = @tiles[@window.mouse_y / @tile_size]
      tile = row[@window.mouse_x / @tile_size]
      if tile
        tile.highlight
      end
    end
  end

  def update

  end

  def draw
    @tiles.each do |cols|
      cols.map {|t| t.draw }
    end
  end

#  private
#  def determine_waypoints # [[x1, y1], [x2, y2],..., [xn, yn]]
#    #first waypoint
#    @waypoints << [@tiles[@tiles.size - 1].index(1), @tiles.size - 1]
#
#    @direction = [0, -1]
#    @current_x = @waypoints.first.first
#    @current_y = @waypoints.first.last + @direction.last
#
#    begin
#
#      until @current_y == 0
##        if @direction.first == 0 &&
##                @current_x + @direction.first < 0 || @current_x + @direction.first > @current_x.size - 1
##          change_direction
##
##        elsif @current_y + @direction.last < 0 || @current_y + @direction.last > @current_x.size - 1
##          change_direction
##        end
#
#        if @tiles[@current_x + @direction.first][@current_y + @direction.last] == 1
#          next_tile
#        else
#          @waypoints << [@current_x, @current_y]
#
#          change_direction
#
#          next_tile
#        end
#
#      end
#
##    rescue
#    end
#
#  end
#
#  def change_direction
#    if @direction.first == 0
#      if @tiles[@current_x - 1][@current_y] == 1
#        @direction = [-1,0]
#      else
#        @direction = [1,0]
#      end
#    else
#      if @tiles[@current_x][@current_y + 1] == 1
#        @direction = [0,1]
#      else
#        @direction = [0,-1]
#      end
#    end
#  end
#
#  def next_tile
#    @current_x = @current_x + @direction.first
#    @current_y = @current_y + @direction.last
#  end
end