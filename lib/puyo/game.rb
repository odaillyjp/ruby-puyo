# encoding: utf-8
module Puyo
  class Game
    attr_reader :chain, :remove, :total_remove

    def initialize(path, output = STDOUT)
      @puyo = Block.new(File::open(path).read)
      @output = output
      @chain = 0
      @remove = 0
      @total_remove = 0
    end

    def start
      print_field

      loop do
        print_field if @puyo.fall
        @remove = @puyo.focus_same
        break if @remove == 0
        @chain += 1
        @total_remove += @remove
        print_chain
        print_remove
        print_field
        @puyo.clear
        print_field
      end
    end

    private

    def print_field
      @output.puts @puyo.field
      @output.puts "----------"
    end

    def print_chain
      @output.puts "< #{@chain} chain >"
    end

    def print_remove
      @output.puts "< #{@remove} remove >"
    end
  end
end
