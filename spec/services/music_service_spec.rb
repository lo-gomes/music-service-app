require 'rails_helper'

describe MusicService do
  describe '#call' do
    context 'given 99 bottles' do
      it 'should return the correct song body' do
        number_of_bottles = 99
        service = MusicService.new(bottles: number_of_bottles)

        expect(service.call).to eq(build_song_body(number_of_bottles))
      end
    end

    context 'given 2 bottles' do
      it 'should return singular form correctly' do
        number_of_bottles = 2

        service = MusicService.new(bottles: number_of_bottles)
        result = service.call

        expect(result).to include("Take one down and pass it around, 1 bottle of beer on the wall.")
        expect(result).to eq(build_song_body(number_of_bottles))
      end
    end

    context 'given 1 bottle' do
      it 'should return "Take one down" verse with "no more bottles of beer"' do
        number_of_bottles = 1

        service = MusicService.new(bottles: number_of_bottles)
        result = service.call

        expect(result).to include("Take one down and pass it around, no more bottles of beer on the wall.")
        expect(result).to eq(build_song_body(number_of_bottles))
      end
    end

    context 'given 0 bottles' do
      it 'should return the end of the song correctly' do
        number_of_bottles = 0

        expected_result = [
          "No more bottles of beer on the wall, no more bottles of beer.",
          "Go to the store and buy some more, no more bottles of beer on the wall."
        ].join(' ')

        service = MusicService.new(bottles: number_of_bottles)
        result = service.call

        expect(result).to eq(expected_result)
      end
    end

    context 'given a negative number of bottles' do
      it 'should raise an error' do
        expect { MusicService.new(bottles: -1) }.to raise_error(RuntimeError)
      end
    end

    def build_song_body(bottles_count)
      result = []

      (bottles_count).downto(1).each do |counter|
        result << "#{bottles(counter)} of beer on the wall, #{bottles(counter)} of beer. Take one down and pass it around, #{bottles(counter - 1)} of beer on the wall."
      end

      result << "No more bottles of beer on the wall, no more bottles of beer."
      result << "Go to the store and buy some more, #{bottles(bottles_count)} of beer on the wall."

      result.join(' ')
    end

    def bottles(num)
      "#{num == 0 ? 'no more' : num} #{num == 1 ? 'bottle' : 'bottles'}"
    end
  end
end
