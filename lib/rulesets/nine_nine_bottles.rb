module Rulesets
  include Wongi::Engine::DSL
  extend self

  ruleset '99 bottles' do
    rule 'new song' do
      forall {
        has :Song, :song, :'99_bottles'
      }

      make {
        gen :Song, :bottles, 99
      }
    end

    rule 'many more bottles' do
      forall {
        has :Song, :bottles, :Quantity
        greater :Quantity, 2
        assign :NewQuantity do |token|
          token[:Quantity] - 1
        end
      }

      make {
        action { |token|
          token[:Song].write("#{token[:Quantity]} bottles of beer on the wall, #{token[:Quantity]} bottles of beer.\n")
          token[:Song].write("Take one down and pass it around, #{token[:NewQuantity]} bottles of beer on the wall.\n\n")
        }
        gen :Song, :bottles, :NewQuantity
      }
    end

    rule 'two bottles' do
      forall {
        has :Song, :bottles, :Quantity
        same :Quantity, 2
      }

      make {
        action { |token|
          token[:Song].write("#{token[:Quantity]} bottles of beer on the wall, #{token[:Quantity]} bottles of beer.\n")
          token[:Song].write("Take one down and pass it around, 1 bottle of beer on the wall.\n\n")
        }
        gen :Song, :bottles, 1
      }
    end

    rule 'one bottle' do
      forall {
        has :Song, :bottles, :Quantity
        same :Quantity, 1
      }

      make {
        action { |token|
          token[:Song].write("1 bottle of beer on the wall, 1 bottle of beer.\n")
          token[:Song].write("Take one down and pass it around, no more bottles of beer on the wall.\n\n")
        }
        gen :Song, :bottles, 0
      }
    end

    rule 'no bottles' do
      forall {
        has :Song, :bottles, :Quantity
        same :Quantity, 0
      }

      make {
        action { |token|
          token[:Song].write("No more bottles of beer on the wall, no more bottles of beer.\n")
          token[:Song].write("Go to the store and buy some more, 99 bottles of beer on the wall.")
        }
      }
    end
  end
end
