require 'foundations/compact'
require 'autocode'

module Spitball
  include Waves::Foundations::Compact

  module Resources
    include AutoCode
    auto_load true, :directories => '.'

    class Map
      on( true ) { to( :greeting ) }
    end
  end

  module Configurations
    class Development
      reloadable [ Resources ]
    end
  end

end