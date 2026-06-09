class Criatura {

  const property poderMagico
  var rol

  method poderOfensivo() {

    return poderMagico * 10 + rol.extra()

  }

  method esFormidable(){
     return self.esAstuta() or self.esExtraordinaria()
  }

  method esAstuta()

  method astucia()

  method esExtraordinaria() {

    return rol.esExtraordinario(self)
  }

  method cambiarADomadorCon(unaMascota){
    if (rol == guardian && unaMascota.cuernos() && unaMascota.edad() ==1){
      rol = Domador
      rol.mascotas().agregarMascota(unaMascota)
    }
  }

  method cambiarAGuardian(){
    if(rol == hechicero){
      rol = guardian
    }
  }

  method cambiarAHechicero(){
    if (rol == Domador && rol.mascotas().any({m=> m.cuernos()})){
      rol = hechicero
    }
    else {
      self.error("no se pudo cambiar rol")
    }

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
  const property astucia

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



}

object hechicero {

  method extra() {
    return 0
  }

  method esExtraordinario(unaCriatura){

    return true

  }

}

class Domador {

  const property mascotas = []

  method agregarMascota(unaMascota) {

    mascotas.add(unaMascota)

  }

  method quitarMascota(unaMascota) {

    mascotas.remove(unaMascota)

  }

  method extra() {
    return 150 * mascotas.filter({m => m.cuernos()}).size()
  }

  method esExtraordinario(unaCriatura){

    return unaCriatura.poderMagico() >= 15 && mascotas.all({m=> m.esVeterana()})

  }

}

class Mascota {

  var property edad
  const property cuernos
  const property esVeterana

}

