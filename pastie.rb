require 'markaby'
module Spitball
  module Resources
    class Pastie
      include Waves::Resources::Mixin
      
      # Request dispatching declarations
      on( :get, [ 'pasties' ] ) { list }
      on( :get, [ 'pasties', :name ]) { show( captured.name ) }
      
      # Resource methods
      def list
        pasties = Dir.entries( 'pasties' ).slice(2..-1)
        
        layout :title => "Spitball presents Pasties" do
          h1 "Have some pasties!"
          ul do
            pasties.each do |pastie|
              li { a pastie, :href => "/pasties/#{pastie}" }
            end
          end
        end
        
      end
      
      def show(name)
        pastie = "pasties/#{name}"
        raise Waves::Dispatchers::NotFoundError unless File.exist?( pastie )
        string = File.read( pastie )
        
        layout :title => "pastie #{name}" do
          h1 "Here's a hot pastie!"
          hr
          pre { text(string) }
          hr
        end
      end
      
      def layout( assigns = {}, &block )
        Markaby::Builder.new assigns do
          
          html do
            head { title @title }
            body do
              div.main!(&block)
            end
          end
          
        end
      end
      
    end
  end
end