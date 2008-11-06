require 'foundations/compact'
require 'autocode'

module Spitball
  include Waves::Foundations::Compact

  module Resources
    include AutoCode
    auto_load true, :directories => '.'

    class Map
      on( true, [ 'hello' ] ) { to( :greeting ) }
      on( true, [ 'hello', true ] ) { to( :greeting ) }
      
      on( true, [ 'pasties' ] ) { to( :pastie ) }
      on( true, [ 'pasties', true ] ) { to( :pastie ) }
    end
  end

  module Configurations
    class Development
      reloadable [ Resources ]
    end
  end

end