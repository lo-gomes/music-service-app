class MusicService
  def initialize(bottles:)
    raise RuntimeError, "bottles should be a positive integer." if bottles.negative?

    @bottles = bottles
  end

  def call
    result = []

    (bottles).downto(1).each do |bottles_count|
      result << "#{bottles_str(bottles_count)} of beer on the wall, #{bottles_str(bottles_count)} of beer. Take one down and pass it around, #{bottles_str(bottles_count - 1)} of beer on the wall."
    end

    result << "No more bottles of beer on the wall, no more bottles of beer."
    result << "Go to the store and buy some more, #{bottles_str(bottles)} of beer on the wall."

    result.join(' ')
  end

  private

  attr_accessor :bottles

  def bottles_str(num)
    "#{num == 0 ? 'no more' : num} #{num == 1 ? 'bottle' : 'bottles'}"
  end
end
