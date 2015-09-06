require 'spec_helper'

describe Paxx::NameNormalizer do
  let(:keys){ ["TestA","TestAa","TestAas","TestAase"]}
  let(:name1) {'Test Åsen'}
  let(:normalizer) {Paxx::NameNormalizer.new(name1)}

  context "Norwegian names" do
    it "should handle special caracters" do
      expect(normalizer.normalize).to eq("Test Åsen")
    end

    it "should be able to make ID" do
      expect(normalizer.as_id).to eq("testaasen")
    end

    it "should handle first_name and last_name for 2 word names" do
      expect(normalizer.first_name).to eq("Test")
      expect(normalizer.last_name).to eq("Åsen")
    end

    it "should be valid" do
      expect(normalizer.valid).to be
    end

    it "should genereate shortref when no check is given" do
      expect( normalizer.as_short_ref).to eq("TestAa")
    end


    it "should genereate shortref " do
      result  = normalizer.as_short_ref do |name|
        name != "TestAa"
      end

      expect( result).to eq("TestAas")
    end

    it "should genereate shortref " do
      result  = normalizer.as_short_ref do |name|
        keys.index(name).nil?
      end

      expect( result).to eq("TestAasen")
    end

  end

end