# encoding: UTF-8

class DirectorTecnico
    def initialize(nombre)
        @nombre = nombre
    end

    def to_s
        nombre
    end

    def ==(o)
      o.class == self.class && o.state == self.state
    end

    protected

    def state
      self.instance_variables.map { |variable| self.instance_variable_get variable }
    end
end