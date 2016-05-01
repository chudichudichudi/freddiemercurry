# encoding: UTF-8

class DirectorTecnico
    def initialize(nombre, libroDeEstrategias)
        @nombre = nombre

        #convertirlo a acumulada las probabilidades
        acc = 0
        libroDeEstrategias.each { |e,w| libroDeEstrategias[e] = acc+=w }

        @libroDeEstrategias = libroDeEstrategias
    end

    def to_s
        nombre
    end

    def ==(o)
      o.class == self.class && o.state == self.state
    end

    def dameEstrategiaOfensiva
        r = rand()
        selected = @libroDeEstrategias.select{ |e,w| w>r }
        return selected.to_a()[0][0]
    end

    def dameEstrategiaDefensiva(turno)
        
    end

    def dameEstrategiaContraOfensiva(turno)
        
    end

    protected

    def state
      self.instance_variables.map { |variable| self.instance_variable_get variable }
    end
end