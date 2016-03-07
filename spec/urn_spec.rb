require 'urn'

RSpec.describe URN do
  describe '#valid?' do
    context 'returns true' do
      it 'if it is valid' do
        expect(described_class.new('urn:namespace:specificstring')).to be_valid
      end

      it 'if namespace includes urn' do
        expect(described_class.new('urn:urnnamespace:specificstring')).to be_valid
      end
    end

    context 'returns false' do
      it 'if it does not start with urn' do
        expect(described_class.new('not-urn:namespace:specificstring')).not_to be_valid
      end

      it 'if namespace is urn' do
        expect(described_class.new('urn:urn:specificstring')).not_to be_valid
      end
    end
  end

  describe '#normalize' do
    it 'returns nil if it is not valid' do
      expect(described_class.new('urn:').normalize).to be_nil
    end

    it 'lowercases the leading "urn:" token' do
      expect(described_class.new('URN:foo:123').normalize).to eq('urn:foo:123')
    end

    it 'lowercases the NID' do
      expect(described_class.new('urn:FOO:123').normalize).to eq('urn:foo:123')
    end

    it 'lowercases %-escaping in the NSS' do
      expect(described_class.new('urn:foo:123%2C456').normalize).to eq('urn:foo:123%2c456')
    end

    it 'does not lowercase other characters in the NSS' do
      expect(described_class.new('urn:foo:BA%2CR').normalize).to eq('urn:foo:BA%2cR')
    end
  end
end
