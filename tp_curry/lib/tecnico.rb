# encoding: UTF-8

class DirectorTecnico
    def initialize(nombre, libroDeEstrategiasOfensivas, libroDeEstrategiasDefensivas)
        @nombre = nombre
        #convertirlo a acumulada las probabilidades
        acc = 0
        libroDeEstrategiasOfensivas.each { |e,w| libroDeEstrategiasOfensivas[e] = acc+=w }
        acc = 0
        libroDeEstrategiasDefensivas.each { |e,w| libroDeEstrategiasDefensivas[e] = acc+=w }

        @libroDeEstrategiasOfensivas = libroDeEstrategiasOfensivas
        @libroDeEstrategiasDefensivas = libroDeEstrategiasDefensivas
    end

    def to_s
        nombre
    end

    def ==(o)
      o.class == self.class && o.state == self.state
    end

    def dameEstrategiaOfensiva(turno)
        r = rand()
        selected = @libroDeEstrategiasOfensivas.select{ |e,w| w>r }
        return selected.to_a()[0][0]
    end

    def dameEstrategiaDefensiva(turno)
        r = rand()
        selected = @libroDeEstrategiasDefensivas.select{ |e,w| w>r }
        return selected.to_a()[0][0]
    end

    protected

    def state
      self.instance_variables.map { |variable| self.instance_variable_get variable }
    end
end