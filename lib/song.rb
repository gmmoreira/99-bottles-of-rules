require 'bundler/setup'

require 'forwardable'
require 'wongi-engine'
require_relative 'rulesets/nine_nine_bottles'

class Song
  extend Forwardable

  def initialize
    @io = StringIO.new
  end

  def_delegators :@io, :write

  def to_s
    @io.string
  end

  # songs
  @@song_engine = Wongi::Engine.create
  @@song_engine << Wongi::Engine::Ruleset["99 bottles"]

  def self.nine_nine_bottles
    song = self.new

    @@song_engine.with_overlay do |overlay|
      overlay << [song, :song, :'99_bottles']
    end

    song.to_s
  end
end
