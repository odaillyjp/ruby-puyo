require 'spec_helper'

module Puyo
  describe Game do
    describe "#start" do
      let(:path) { 'puyo.txt' }
      let(:output) { double('output').as_null_object }
      let(:game) { Game.new(path, output) }

      it "sends to init field" do
        INIT_FIELD = File::open(path).read
        output.should_receive(:puts).with(INIT_FIELD)
        game.start
      end

      it "sends to blank field" do
        BLANK_FIELD = "      \n" * 13
        output.should_receive(:puts).with(BLANK_FIELD)
        game.start
      end

      it "chain should 18" do
        game.start
        game.chain.should eq(18)
      end

      it "total_remove should 74" do
        game.start
        game.total_remove.should eq(74)
      end
    end
  end
end
