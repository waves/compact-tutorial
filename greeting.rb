module Spitball
  module Resources
    class Greeting
      include Waves::Resources::Mixin
      on( :get, [ 'hello' ] ) { "Hello World!" }
      on( :get, [ 'hello', :name ] ) { "Hello, #{captured.name}!" }
    end
  end
end