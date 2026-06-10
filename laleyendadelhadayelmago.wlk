class Criatura {
  const astucia
  var poderMagico
  var rol
  method poderMagico() = poderMagico
  method perder15DePoder() {
    poderMagico = poderMagico * 0.85
  }
  method poderOfensivo() {

    return poderMagico * 10 + rol.extra()

  }
  method esFormidable(){
     return self.esAstuta() or self.esExtraordinaria()
  }
  method esAstuta()
  method astucia() = astucia
  method esExtraordinaria() {
    return rol.esExtraordinario(self)
  }



  method ritual() {
    rol = rol.nuevoRolPorRitual()
  }


}



class Duende inherits Criatura {

  override method poderOfensivo() {
    return super() * 1.1
  }

  override method esAstuta(){
    return false
  }

  override method astucia(){
    return 0
  }

  



}

class Hada inherits Criatura {

  var kilometrosQuePuedeVolar = 2

  method aumentarKilometros(unaCantidad) {

    kilometrosQuePuedeVolar = (kilometrosQuePuedeVolar + unaCantidad).min(25)

  }

  override method esAstuta(){
    return astucia > 50
  }

  override method esExtraordinaria(){
    return super() && kilometrosQuePuedeVolar > 10
  }





}



object guardian {

  method extra(){
    return 100
  }

  method esExtraordinario(unaCriatura){
    return unaCriatura.poderMagico() > 50
  }

  method nuevoRolPorRitual() {
    return new Domador(mascotas=[new Mascota(edad=1, cuernos=false)])
  }


}

object hechicero {

  method extra() {
    return 0
  }

  method esExtraordinario(unaCriatura){
    return true
  }
  method nuevoRolPorRitual() = guardian
}

class Domador {

  const mascotas = []

  method agregarMascota(unaMascota) {
    mascotas.add(unaMascota)
  }

  method quitarMascota(unaMascota) {
    mascotas.remove(unaMascota)
  }

  method extra() {
    //return 150 * mascotas.filter({m => m.cuernos()}).size()
    return 150 * self.cantidadMascotasConCuernos()
  }
  method cantidadMascotasConCuernos() = mascotas.count({m=>m.cuernos()})
  method esExtraordinario(unaCriatura){
    return unaCriatura.poderMagico() >= 15 && mascotas.all({m=> m.esVeterana()})
  }

  method nuevoRolPorRitual() {
    if(!self.cantidadMascotasConCuernos() > 0) 
      self.error("No puede cambiar a hechicero porque alalalaa")
    return hechicero
  }
}

class Mascota {
  const edad
  const property cuernos
  method esVeterana() = edad >= 10

}

class Colonia {
  const criaturas = []

  method poderOfensivo() = criaturas.sum({c=>c.poderOfensivo()})
  method cantidadDeCriaturasFormidables() {
    return criaturas.count({c=>c.esFormidable()})
  }
  method atacarA(unArea) {
    if(self.poderOfensivo() > unArea.poderDefensivo()) 
      unArea.esUsurpada(self)
    else 
      criaturas.forEach(
        {
          c => c.perder15DePoder()
        }
      )
  }
}

class Area {
  var colonia = new Colonia(criaturas=[])
  method poderDefensivo()
  method esUsurpada(unaColonia) {colonia = unaColonia}
}

class Castillo inherits Area {
  override method poderDefensivo() {
    return 200 * colonia.cantidadDeCriaturasFormidables()
  }
}

class Claro inherits Area {
  override method poderDefensivo() {
    return 100 + colonia.poderOfensivo()
  }
}