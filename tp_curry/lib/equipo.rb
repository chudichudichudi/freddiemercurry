# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Equipo
  def initialize(nombre, directorTecnico, base, alero, alaPivote, escolta, pivote)
    @nombre = nombre
    @directorTecnico = directorTecnico
    @base = base
    @alero = alero
    @alaPivote = alaPivote
    @escolta = escolta
    @pivote  = pivote
  end
  
  def to_s
  	@nombre
  end
end
