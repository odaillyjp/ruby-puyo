$LOAD_PATH.unshift File.expand_path('../lib',__FILE__)
require 'puyo'

game = Puyo::Game.new('puyo.txt')
game.start
