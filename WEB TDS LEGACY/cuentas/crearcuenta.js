var ajax = null;
var nombreNivel = ["", "Baja", "Media", "Alta"];
var ultimoNombreCuenta = "";

function nuevoAjax() {
    return new XMLHttpRequest();
}

function nombreDisponible() {
    var nombreCuenta = document.getElementById("username");
    var caja = document.getElementById("errusername");
    if (ultimoNombreCuenta != nombreCuenta.value) {
        ultimoNombreCuenta = nombreCuenta.value;
        caja.className = "noerr";
        if (!isNombreCuentaValido(nombreCuenta.value)) {
            document.getElementById("txtusername").innerHTML =
                "El nombre ingresado no es válido.";
            caja.className = "err";
            return false;
        }
        var imgCargando = document.getElementById("imgCargando");
        var botonComprobar = document.getElementById("comprobar");
        botonComprobar.value = "Comprobando...";
        botonComprobar.disabled = "disabled";
        imgCargando.className = "comprobando";
        ajax = nuevoAjax();
        ajax.open("POST", "/cuentas/nombredisponible.php");
        ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        ajax.send(
            "NombreCuenta=" +
            nombreCuenta.value
        );
        ajax.onreadystatechange = function() {
            if (ajax.readyState == 4) {
                var resultado = ajax.responseText;
                imgCargando.className = "";
                botonComprobar.value = "Comprobar disponibilidad";
                botonComprobar.disabled = "";
                if (resultado == 1) {
                    caja.className = "noerrOK";
                    document.getElementById("txtusername").innerHTML = "Nombre de cuenta disponible.";
                    return true;
                } else {
                    document.getElementById("txtusername").innerHTML =
                        "Ya existe el nombre de cuenta que deseas utilizar.<a href='./cpremium.php?a=recupass'>¿Olvidaste tu contraseña?</a> ";
                    caja.className = "err";
                    return false;
                }
            }
        };
    }
}

function mostrarPoderClave(nombre, barra) {
    var nombre_barra = "txt_" + barra;
    var barraElement = document.getElementById(barra);
    var txtBarra = document.getElementById(nombre_barra);
    var poder = poderClave(nombre.value);
    txtBarra.innerHTML = nombreNivel[poder];
    barraElement.style.width = 77 * poder + "px";
    return false;
}

function verificarFormulario() {
    var botonEnviar = document.getElementById("Submit");
    botonEnviar.value = "Procesando...";
    var hayError = false;
    var primerFocus = null;
    var campo = document.getElementById("username");
    var resultado = document.getElementById("errusername");
    if (!isNombreCuentaValido(campo.value)) {
        document.getElementById("txtusername").innerHTML =
            "El nombre ingresado no es válido.";
        resultado.className = "err";
        hayError = true;
        if (primerFocus == null) primerFocus = campo;
    }
    campo = document.getElementById("password");
    resultado = document.getElementById("errpassword");
    if (!isClaveCuentaValida(campo.value)) {
        document.getElementById("txtpassword").innerHTML =
            "La contraseña ingresada no es válida.";
        resultado.className = "err";
        hayError = true;
        if (primerFocus == null) primerFocus = campo;
    }
    campo = document.getElementById("password2");
    resultado = document.getElementById("errorpassword2");
    if (
        !isConfirmarClaveCuentaValida(
            campo.value,
            document.getElementById("password").value
        )
    ) {
        document.getElementById("errorpassword2").innerHTML =
            "Las contraseñas no coinciden.";
        resultado.className = "err";
        hayError = true;
        if (primerFocus == null) primerFocus = campo;
    }
    
    if (hayError) {
        primerFocus.focus();
        botonEnviar.value = "Enviar";

        return false;
    } else {
        botonEnviar.value = "Enviando...";
        return true;
    }
}

function mostrarAyuda(num) { document.getElementById(num).style.display = "block"; }

function ocultarAyuda(num) { document.getElementById(num).style.display = "none"; }

function check(chk) {
    if (chk.className == "checkbox") {
        chk.className = "checkbox On"
        document.getElementById("acepto").value = "1";
    } else { chk.className = "checkbox";
        document.getElementById("acepto").value = "0"; }
}


function chequearReIngreso() { var pass = document.getElementById('password').value; if (pass != '') { var campo = document.getElementById('password2'); var resultado = document.getElementById('errpassword2'); if (campo.value == "") { document.getElementById('errorpassword2').innerHTML = "Por favor, re-ingresa la contraseña.";
            resultado.className = "err"; } else if (pass != campo.value) { document.getElementById('errorpassword2').innerHTML = "Las contraseñas no coinciden.";
            resultado.className = "err"; } else { resultado.className = "noerr"; } } }