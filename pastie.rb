require 'markaby'
require 'digest/md5'
module Spitball
  module Resources
    class Pastie
      include Waves::Resources::Mixin
      
      # Request dispatching declarations
      on( :get, [ 'pasties' ] ) { list }
      on( :get, [ 'pasties', :name ]) { show( captured.name ) }
      on( :get, [ 'pasties', 'form' ]) { form }
      on( :post, [ 'pasties' ] ) { create( query['code'] ) }
      
      # Resource view methods
      def list
        pasties = Dir.entries( 'pasties' ).slice(2..-1)
        
        layout :title => "Spitball presents Pasties" do
          h1 { a "Give me a pastie!", :href => "/pasties/form" }
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
          h1 "Here's a pastie!"
          hr
          pre { text(string) }
          hr
        end
      end
      
      def form
        layout :title => "Create a new pastie" do
          h1 "I want your pastie."
          form :method => :post, :action => "/pasties" do
            label "Code goes here" ; br
            textarea :name => :code, :id => "pastie_code", :rows => 24, :cols => 80; br
            input :type => "submit", :value => "Save"
          end
        end
      end
      
      def create(text)
        digest = Digest::MD5.hexdigest("#{Time.now}#{rand(256)}#{text[0,79]}")
        pastie = "pasties/#{digest}"
        File.open( pastie, 'w' ) { |f| f.print text }
        redirect pastie
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