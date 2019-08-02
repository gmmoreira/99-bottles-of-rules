require 'test_helper'

describe Song do
  let(:song_lyrics) { File.read(File.expand_path('fixtures/song.txt', __dir__)) }

  describe '#nine_nine_bottles' do
    it 'should return the expected song lyrics' do
      expect(Song.nine_nine_bottles).must_equal song_lyrics
    end
  end
end