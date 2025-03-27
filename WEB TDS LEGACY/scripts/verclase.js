var clases = new Array(14)
clases[1] = "MAGO";
clases[2] = "CLERIGO";
clases[3] = "GUERRERO";
clases[4] = "ASESINO";
clases[5] = "LADRON";
clases[6] = "DRUIDA";
clases[7] = "BARDO";
clases[8] = "PALADIN";
clases[9] = "CAZADOR";
clases[10] = "PESCADOR";
clases[11] = "HERRERO";
clases[12] = "LEÑADOR";
clases[13] = "MINERO";
clases[14] = "CARPINTERO";
clases[15] = "PIRATA";

function verclase(clase) {
    var tabla = document.getElementById('tabla_ranking');
    var titulo = document.getElementById('titulo_seccion');
    var ajax = new XMLHttpRequest();
    ajax.open("GET", "estadisticas/rankings/get.php?clase=" + clase);
    ajax.onreadystatechange = function () {
        if (ajax.readyState === 4 && ajax.status === 200) {
            tabla.innerHTML = ajax.responseText;
            titulo.innerHTML = 'Ranking de niveles - ' + clases[clase];
        }
    };
    ajax.send();
}
