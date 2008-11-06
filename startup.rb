require 'foundations/compact'

module Spitball
  include Waves::Foundations::Compact

  module Resources
    class Map
      on( :get, [ 'hello' ] ) { "Hello World!" }
      on( :get, [ 'hello', :name ] ) { "Hello, #{captured.name}!" }
    end
  end

end