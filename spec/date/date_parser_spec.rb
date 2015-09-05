require 'spec_helper'

describe Paxx::DateParser do
  let(:parser) {Paxx::DateParser.new}

  context "6 digits dates on dd.mm.yy format" do
    it "should handle 6 digits date" do
      dt = parser.decode('02.01.00')
      expect(dt.year).to eq(2000)
      expect(dt.month).to eq(1)
      expect(dt.day).to eq(2)
    end

    it "should handle 6 digits date in the 2000 range" do
      dt = parser.decode('01.01.01')
      expect(dt.year).to eq(2001)
    end


    it "should handle 6 digits date in the 1900 range" do
      dt = parser.decode('01.01.55')
      expect(dt.year).to eq(1955)
    end
  end

  context "8 digits dates on dd.mm.yyyy format" do
    it "should handle 8 digits date" do
      dt = parser.decode('20.01.1971')
      expect(dt.year).to eq(1971)

    end

  end

end