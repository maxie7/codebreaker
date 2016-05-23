require 'spec_helper'

module Codebreaker
  RSpec.describe Player do

    context "#initialize" do
      it "@players var has to be an array" do
        expect(subject.instance_variable_get(:@players).is_a?(Array)).to eq(true)
      end
      it "the array of @players has to be empty" do
        expect(subject.instance_variable_get(:@players)).to match([])
      end
    end

    context "#add_player" do
      it "adds a player in @players array" do
        subject.instance_variable_get(:@players).push "Ronaldo"
        expect(subject.instance_variable_get(:@players).size).to eq(1)
      end
    end

    context "#save_information" do
      before do
        allow(File).to receive(:open)
        allow(YAML).to receive(:dump)
        allow(File).to receive(:write)
      end
      it "is not raise an exception" do
        expect{subject.save_info}.not_to raise_exception
      end
      it "puts the error message if the file not found" do
        allow(File).to receive(:exist?).and_return(false)
        expect(subject.save_info).to eq("file not found")
      end
    end

    context "#load_information" do
      it "is not raise an exception" do
        expect{subject.load_info}.not_to raise_exception
      end
      it "puts the error message if the file not found" do
        allow(File).to receive(:exist?).and_return(false)
        expect(subject.load_info).to eq("file not found")
      end
    end
  end
end
