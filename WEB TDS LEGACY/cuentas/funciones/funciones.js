function isCadenaValido(cadena) {
    var checkOK = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ" + "abcdefghijklmnñopqrstuvwxyz " + "0123456789" + ".-_";
    var checkStr = cadena;
    var allValid = true;
    for (i = 0; i < checkStr.length; i++) {
        ch = checkStr.charAt(i);
        for (j = 0; j < checkOK.length; j++)
            if (ch == checkOK.charAt(j)) break;
        if (j == checkOK.length) { allValid = false; break; }
    }
    return allValid;
}

function isNombreCuentaValido(nombre) {
    if (nombre.length == 0 || nombre.length < 3 || nombre.length > 20) { return false; }
    if (isCadenaValido(nombre)) { return true; } else { return false; }
}

function isMailValido(mail) {
    if ((mail.indexOf('@', 0) == -1) || (mail.indexOf('.', 0) == -1)) { return false; }
    return true;
}

function isNombreValido(nombre) { if (nombre.length == 0 || nombre.length < 3 || nombre.length > 20) { return false; } else { return true; } }

function isPassValido(pass) { if (pass.length < 8 || pass.length > 20) { return false; } else { return true; } }

function isPINValido(pin) { if (pin.length < 8 || pin.length > 20) { return false; } else { return true; } }

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

function isGenericoValido(campo) { if (campo.length == 0 || campo.length < 3 || campo.length > 20 || isCadenaValido(campo) != true) { return false; } else { return true; } }

function isNombreApellidoValido(campo) { if (campo.length == 0 || campo.length < 3 || campo.length > 60 || isCadenaValido(campo) != true) { return false; } else { return true; } }