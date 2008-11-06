require 'foundations/compact'

module Spitball
  include Waves::Foundations::Compact

  module Resources
    class Map
      on( :get, [ "hello" ] ) { "Hello World!" }
    end
  end

end