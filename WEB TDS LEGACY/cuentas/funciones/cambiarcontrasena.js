var nombreNivel = new Array("", "Baja", "Media", "Alta");

function mostrarPoderClave(nombre) { var barra = document.getElementById('barra'); var txtBarra = document.getElementById('txt_barra'); var poder = poderClave(nombre.value);
    txtBarra.innerHTML = nombreNivel[poder];
    barra.style.width = 77 * poder + "px"; return false; }

function chequearReIngreso() {
    var pass = document.getElementById('password2').value;
    if (pass != '') { var campo = document.getElementById('password2'); var resultado = document.getElementById('errpassword2'); if (campo.value == "") { document.getElementById('errorpassword2').innerHTML = "Por favor, re-ingresa la contraseña.";
            resultado.className = "err"; return false; } else if (pass != campo.value) { document.getElementById('errorpassword2').innerHTML = "Las contraseñas no coinciden.";
            resultado.className = "err"; return false; } else { resultado.className = "noerr"; return true; } }
    return false;
}

function validarFormulario() {
    var hayError = false;
    var campo = document.getElementById('cActual');
    var resultado = document.getElementById('errPasswordActual');
    if (isPassValido(campo.value) == false) { resultado.className = "err";
        hayError = true; } else { resultado.className = "noerr"; }
    var campo = document.getElementById('Password');
    var resultado = document.getElementById('errPassworNuevo');
    if (isPassValido(campo.value) == false) { resultado.className = "err";
        hayError = true; } else { resultado.className = "noerr"; if (chequearReIngreso() == false) { hayError = true; } }
    var campo = document.getElementById('pin');
    var resultado = document.getElementById('errPIN');
    if (isPINValido(campo.value)) { resultado.className = "noerr"; } else { resultado.className = "err";
        hayError = true; }
    return !hayError;
}