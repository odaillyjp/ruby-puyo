# encoding: utf-8
class Block
  def initialize(file)
    @field = []

    file.each_line do |line|
      field_line = []
      line.chomp!
      line.each_char do |char|
        field_line << char
      end
      @field << field_line
    end

    @field.reverse!
    @width = @field[0].length
    @height = @field.length
  end

  def fall
    fall_flag = false

    @width.times do |x|
      @height.times do |y|
         fall_flag = true if fall_puyo(y,x)
      end
    end

    fall_flag
  end

  def focus_same
    init_check_field
    x = 0
    y = 0
    same_count = 0

    @width.times do |x|
      @height.times do |y|
        unless @check_field[y][x]
          same = find_same(y,x,[])
          if same.length >= 4
            same.each do |pos|
              @field[pos[0]][pos[1]] = '#'
            end
            same_count += same.length
          end
        end
      end
    end

    same_count
  end

  def clear
    @field.each do |line|
      line.map!{|char| char == '#' ? ' ' : char}
    end
  end

  def field
    field_state = ""

    @field.reverse_each do |line|
      field_state += line.join + "\n"
    end

    field_state
  end

  private

  def init_check_field
    @check_field = Array.new
    @height.times do
      @check_field << Array.new(@width,false)
    end
  end

  def fall_puyo(y,x)
    return false if y == 0
    return false if @field[y][x] == ' '
    return false unless @field[y - 1][x] == ' '

    @field[y - 1][x] = @field[y][x]
    @field[y][x] = ' '
    fall_puyo(y - 1,x)

    true
  end

  def find_same(y,x,pos)
    return pos if @field[y][x] == ' '
    return pos if @check_field[y][x]

    pos << [y,x]
    color = @field[y][x]
    @check_field[y][x] = true

    if (x > 0) && (color == @field[y][x - 1]) && !(@check_field[y][x - 1])
      find_same(y,x - 1,pos)
    end
    if (x < @width - 1) && (color == @field[y][x + 1]) && !(@check_field[y][x + 1])
      find_same(y,x + 1,pos)
    end
    if (y > 0) && (color == @field[y - 1][x]) && !(@check_field[y - 1][x])
      find_same(y - 1,x,pos)
    end
    if (y < @height - 1) && (color == @field[y + 1][x]) && !(@check_field[y + 1][x])
      find_same(y + 1,x,pos)
    end

    pos
  end
end
