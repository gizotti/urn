class URN
  PATTERN = 'urn:(?!urn:)[a-z0-9\-]{1,31}:[\S]+'.freeze
  REGEX = /^#{PATTERN}$/i

  attr_reader :urn
  private :urn

  def initialize(urn)
    @urn = urn
  end

  def valid?
    !(urn =~ REGEX).nil?
  end

  def normalize
    return unless valid?

    _scheme, nid, nss = urn.split(':', 3)
    normalized_nid = nid.downcase
    normalized_nss = nss.gsub(/%([0-9a-f]{2})/i) { |hex| hex.downcase }

    "urn:#{normalized_nid}:#{normalized_nss}"
  end
end
