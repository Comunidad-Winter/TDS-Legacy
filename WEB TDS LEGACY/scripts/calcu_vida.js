var raza = 0;
var razaClass = "";
var c1 = "&iexcl;&iexcl;FELICITACIONES!! Tu vida supera la vida de un personaje normal de tu raza, clase y nivel!";
var c2 = "&iexcl;&iexcl;NO TE DESANIMES!! Tu vida est&aacute; por debajo del promedio pero con un buen entrenamiento y un poco de suerte podr&aacute;s alcanzar un mejor promedio.";
var razas = new Array("HUMANO", "ELFO", "ELFO OSCURO", "GNOMO", "ENANO");
var clases = new Array("MAGO", "CLERIGO", "GUERERRO", "ASESINO", "LADRON", "BARDO", "DRUIDA", "PALADIN", "CAZADOR", "PESCADOR", "HERRERO", "LEÑADOR", "MINERO", "CARPINTERO", "PIRATA");

function selectRaza(numero) {
    if (raza != 0) { document.getElementById("r" + raza).className = razaClass; }
    razaClass = document.getElementById("r" + numero).className;
    raza = parseInt(numero);
    document.getElementById("r" + raza).className = razaClass + " On";
    return false;
}

function calcular() {
    resultado = document.getElementById("resultados");
    resultado.style.display = "none";
    var nivel = parseInt(document.getElementById("nivel").value);
    var vida = parseInt(document.getElementById("vida").value);
    if (isNaN(nivel) || nivel <= 0) { alert("El nivel ingresado NO es correcto."); return false; }
    if (isNaN(vida) || vida < 20) { alert("La vida ingresada NO es correcta."); return false; }
    for (var i = 0; i < 17; i++) { opcion = document.getElementsByName("clase")[i]; if (opcion.checked) { clase = parseInt(opcion.value); break; } }
    var promedio = 0;
    promedio = obtenerPromedio(clase, raza);
    var mi_pj = document.getElementById("mi_pj");
    var mi_nivel = document.getElementById("mi_nivel");
    var mi_vida = document.getElementById("mi_vida");
    mi_nivel.innerHTML = nivel;
    mi_pj.innerHTML = razas[raza - 1] + " " + clases[clase - 1];
    mi_vida.innerHTML = vida;
    document.getElementById("prom_ideal").innerHTML = promedio;
    //if (clase == 4) { 
    //	var promedioReal = (vida - 30) / (nivel - 1); 
    //} else { 
    	var promedioReal = (vida - 15) / (nivel);
promedioReal = Math.round(promedioReal * 10) / 10;

    //}
	promedioReal = promedioReal.toFixed(2);
    document.getElementById("prom_real").innerHTML = promedioReal;
    //if (clase == 4) {
    //    document.getElementById("vida_ideal").innerHTML = parseInt(promedio * (nivel - 1)) + 30;
    //} else {
        document.getElementById("vida_ideal").innerHTML = parseInt(promedio * nivel) + 15;
    //}
    if (promedioReal >= promedio) { document.getElementById("conclusion").innerHTML = c1; } else { document.getElementById("conclusion").innerHTML = c2; }
    resultado.style.display = "";
    return true;
}

function obtenerPromedio(clase, raza) {
    var prom = 0;
    switch (clase) {
        case 1: // Mago
            switch (raza) {
                case 1:
                    prom = 6.5;
                    break;
                case 2:
                    prom = 6;
                    break;
                case 3:
                    prom = 6;
                    break;
                case 4:
                    prom = 5.5;
                    break;
                case 5:
                    prom = 7;
                    break;
            }
            break;
        case 2: // Clerigo
            switch (raza) {
                case 1:
                    prom = 8;
                    break;
                case 2:
                    prom = 7.5;
                    break;
                case 3:
                    prom = 7.5;
                    break;
                case 4:
                    prom = 7;
                    break;
                case 5:
                    prom = 8.5;
                    break;
            }
            break;

        case 3: // Guerrero
            switch (raza) {
                case 1:
                    prom = 10;
                    break;
                case 2:
                    prom = 9.5;
                    break;
                case 3:
                    prom = 9.5;
                    break;
                case 4:
                    prom = 9;
                    break;
                case 5:
                    prom = 10.5;
                    break;
            }
            break;

        case 4: // Asesino
            switch (raza) {
                case 1:
                    prom = 8;
                    break;
                case 2:
                    prom = 7.5;
                    break;
                case 3:
                    prom = 7.5;
                    break;
                case 4:
                    prom = 7;
                    break;
                case 5:
                    prom = 8.5;
                    break;
            }
            break;


        case 5: // Ladrón
            switch (raza) {
                case 1:
                    prom = 7;
                    break;
                case 2:
                    prom = 6.5;
                    break;
                case 3:
                    prom = 6.5;
                    break;
                case 4:
                    prom = 6;
                    break;
                case 5:
                    prom = 7.5;
                    break;
            }
            break;

        case 6: // Bardo
            switch (raza) {
                case 1:
                    prom = 8;
                    break;
                case 2:
                    prom = 7.5;
                    break;
                case 3:
                    prom = 7.5;
                    break;
                case 4:
                    prom = 7;
                    break;
                case 5:
                    prom = 8.5;
                    break;
            }
            break;
        case 7: // Druida
            switch (raza) {
                case 1:
                    prom = 8;
                    break;
                case 2:
                    prom = 7.5;
                    break;
                case 3:
                    prom = 7.5;
                    break;
                case 4:
                    prom = 7;
                    break;
                case 5:
                    prom = 8.5;
                    break;
            }
            break;




        case 8: // Paladin
            switch (raza) {
                case 1:
                    prom = 9.5;
                    break;
                case 2:
                    prom = 9;
                    break;
                case 3:
                    prom = 9;
                    break;
                case 4:
                    prom = 8.5;
                    break;
                case 5:
                    prom = 10;
                    break;
            }
            break;
        case 9: // Cazador
            switch (raza) {
                case 1:
                    prom = 9.5;
                    break;
                case 2:
                    prom = 9;
                    break;
                case 3:
                    prom = 9;
                    break;
                case 4:
                    prom = 8.5;
                    break;
                case 5:
                    prom = 10;
                    break;
            }
            break;


        case 10: // Pescador
            switch (raza) {
                case 1:
                    prom = 6.5;
                    break;
                case 2:
                    prom = 6;
                    break;
                case 3:
                    prom = 6;
                    break;
                case 4:
                    prom = 5.5;
                    break;
                case 5:
                    prom = 7;
                    break;
            }
            break;
        case 11: // Herrero
            switch (raza) {
                case 1:
                    prom = 6.5;
                    break;
                case 2:
                    prom = 6;
                    break;
                case 3:
                    prom = 6;
                    break;
                case 4:
                    prom = 5.5;
                    break;
                case 5:
                    prom = 7;
                    break;
            }
            break;
        case 12: // leñador
            switch (raza) {
                case 1:
                    prom = 6.5;
                    break;
                case 2:
                    prom = 6;
                    break;
                case 3:
                    prom = 6;
                    break;
                case 4:
                    prom = 5.5;
                    break;
                case 5:
                    prom = 7;
                    break;
            }
            break;
        case 13: // minero
            switch (raza) {
                case 1:
                    prom = 6.5;
                    break;
                case 2:
                    prom = 6;
                    break;
                case 3:
                    prom = 6;
                    break;
                case 4:
                    prom = 5.5;
                    break;
                case 5:
                    prom = 7;
                    break;
            }
            break;
        case 14: // carpintero
            switch (raza) {
                case 1:
                    prom = 6.5;
                    break;
                case 2:
                    prom = 6;
                    break;
                case 3:
                    prom = 6;
                    break;
                case 4:
                    prom = 5.5;
                    break;
                case 5:
                    prom = 7;
                    break;
            }
            break;
        case 15: // Pirata
            switch (raza) {
                case 1:
                    prom = 9.5;
                    break;
                case 2:
                    prom = 9;
                    break;
                case 3:
                    prom = 9;
                    break;
                case 4:
                    prom = 8.5;
                    break;
                case 5:
                    prom = 10;
                    break;
            }
            break;
    }
    return prom;
}