require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    subject(:game) {described_class.new}

    context "#start" do
      before do
        game.start
      end

      it "saves secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end

      it "generates secret code" do
        allow(game).to receive(:generate_secret_code).and_return("1234")
        game.start
        expect(game.instance_variable_get(:@secret_code)).to eq("1234")
      end
    end

    context "#guess_validation" do
      before do
        subject.instance_variable_set :@secret_code, "1234"
      end

      it "has to return error message if it isn't a number" do
        expect(subject.guess_check "qwer").to eq("number failed")
      end

      it "has to return error message if size not equal 4" do
        expect(subject.guess_check "12345").to eq("the number must have 4 digits")
      end

      it "has to decrease move_number by 1" do
        expect{subject.guess_check "1234"}.to change{subject.instance_variable_get(:@move_number)}.by(-1)
      end

      it "returns '++++' when 4(winner) exact match" do
        expect(subject.guess_check "1234").to eq("++++")
      end
    end

    context '#guess_check' do
      before do
        subject.instance_variable_set :@secret_code, "1234"
      end

      guess_and_result = [%w(1555 +),   %w(2555 -),  %w(2155 --),  %w(2145 ---),
                          %w(2143 ----),%w(1255 ++), %w(1235 +++), %w(1234 ++++),
                          %w(1553 +-),  %w(1325 +--),%w(1342 +---),%w(1245 ++-), %w(1243 ++--)]
      guess_and_result.each do |element|
        it "guess #{element[0]} should return #{element[1]}" do
          expect(subject.send(:guess_check, element[0])).to eq element[1]
        end
      end
    end

    context "#hint" do
      it "has to decrease @hints by 1" do
        expect{subject.hint}.to change{subject.instance_variable_get(:@hints)}.by(-1)
      end

      it "has to return random number from secret code" do
        subject.instance_variable_set(:@secret_code, "3456")
        allow(subject).to receive(:rand).with(4).and_return(3)
        expect(subject.hint).to eq("One of the numbers in the secret code is 6")
      end
    end
  end
end
