require "observer"

module GestaltRuby
  class ConfObserver
    def initialize( prefix, parent )
      @prefix = prefix
      @parent = parent
    end
    def update( name, value, old_value, source )
      new_name = @prefix + name;
      @parent.change( new_name, value, old_value, source );
    end
  end

  class Configuration
    include Observable
    
    def initialize(options = nil) 
      options = {} unless options
      @options = options
      @values = {}
      @sources = {}
      @observers = {}
    end

    def change(name, value, old_value, source )
      changed
      notify_observers( name, value, old_value, source )
    end

    def getPath(name)
      names = nil

      if( name.is_a?(Array) ) then
        names = name
      elsif( name =~ /:/ ) then
        names = name.split(':')     
      else
        names = [ name ]
      end

      names
    end

    def get(name)
      names = getPath(name)
      
      n = names.shift
      
      if( names.length > 0 ) then
        return @values[n] && @values[n].get( names )
      else
        return @values[n]
      end
      
    end
    
    def getValSource(name)
      names = getPath( name )
      n = names.shift
      if( names.length > 0 )
        return @values[n].getValSource(names)
      else
        return { :value => @values[n], :source => @sources[n] }
      end
    end
    
    def has(name)
      false
    end

    def set(name, value, source=nil)
      names = getPath( name )
      n = names.shift
      if( names.length > 0 ) then
        if( ! @values[n] ) then
            @values[n] = Configuration.new( @options )
            @observers[n] = ConfObserver.new( n + ":", self )
        end
        @values[n].set( names, value, source )
        
      else
        old_value = @values[n]
        changed if old_value != value
        @values[n] = value
        @sources[n] = source
        notify_observers( n, value, old_value, source ) 
      end
    end

    def update(name, value, source)
    end

    def remove(name)
    end

    def each
    end

    def keys
    end
    
    def report
    end

    def toHash
    end

    def writeFile
    end

    def options
    end

    def addPatternListener
    end

    def removePatternListener
    end

    def state
    end

  end

end

