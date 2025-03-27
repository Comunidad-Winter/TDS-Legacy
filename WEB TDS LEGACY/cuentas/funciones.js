function verificarTamaño(campo, min, max) {
    return campo.length >= min && campo.length <= max;
  }
  
  function isCadenaValida2(cadena) {
    return /^[\w\s._-áéíóúàèìòùâêîôûäëïöüÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÄËÏÖÜ]*$/.test(cadena);
  }

  function isCadenaValida(cadena) {
    return /^[a-zA-Z0-9]*$/.test(cadena);
}

  
  function isNombreCuentaValido(nombre) {
    return verificarTamaño(nombre, 3, 20) && isCadenaValida(nombre);
  }
  
  function isMailValido(mail) {
    return mail.includes('@') && mail.includes('.') && verificarTamaño(mail, 4, Infinity);
  }
  
  function isNombreValido(nombre) {
    return verificarTamaño(nombre, 3, 20);
  }
  
  function isPassValido(pass) {
    return verificarTamaño(pass, 4, 20);
  }
  
  function isPINValido(pin) {
    return verificarTamaño(pin, 4, 20);
  }
  
  function poderClave(nombre) {
        if (nombre.length < 8) { return 0; }
    var mayusculas = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
    var minusculas = "abcdefghijklmnñopqrstuvwxyz ";
    var numeros = "0123456789";
    var nivel = 0;
    var checkStr = nombre;
    var subio = false;
    for (i = 0; i < checkStr.length; i++) {
        ch = checkStr.charAt(i);
        for (j = 0; j < mayusculas.length; j++) { if (ch == mayusculas.charAt(j)) { nivel++;
                subio = true; } }
        if (subio) break;
    }
    subio = false;
    for (i = 0; i < checkStr.length; i++) {
        ch = checkStr.charAt(i);
        for (j = 0; j < minusculas.length; j++) { if (ch == minusculas.charAt(j)) { nivel++;
                subio = true; } }
        if (subio) break;
    }
    subio = false;
    for (i = 0; i < checkStr.length; i++) {
        ch = checkStr.charAt(i);
        for (j = 0; j < numeros.length; j++) { if (ch == numeros.charAt(j)) { nivel++;
                subio = true; } }
        if (subio) break;
    }
    return nivel;
  }
  
  function isGenericoValido(campo) {
    return verificarTamaño(campo, 3, 20) && isCadenaValida(campo);
  }
  
  function isNombreApellidoValido(campo) {
    return verificarTamaño(campo, 3, 20) && isCadenaValida(campo);
  }