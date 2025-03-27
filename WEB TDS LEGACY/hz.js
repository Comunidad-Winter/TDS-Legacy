var theTop = 30;

function nuevoAjax2() {
    var xmlhttp = false;
    try { xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); } catch (E) { xmlhttp = false; } }
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') { xmlhttp = new XMLHttpRequest(); }
    return xmlhttp;
}

function ocultarhechizo() { document.getElementById('divhechi').style.display = "none"; }

function ocultar_emergente() { document.getElementById('divemergente').style.display = "none"; }

function ocultaritem() { document.getElementById('info_item').style.display = "none"; }

function verhechizo(id) {
    var i;
    var bloque;
    ocultaritem();
    document.getElementById('nombre').innerHTML = "Cargando...";
    bloque = document.getElementById('divhechi');
    bloque.style.display = 'block';
    if (window.innerHeight) { pos = window.scrollY } else if (document.documentElement && document.documentElement.scrollTop) { pos = document.documentElement.scrollTop } else if (document.body) { pos = document.body.scrollTop }
    if (pos < theTop)
        pos = theTop;
    else
        pos += 30;
    bloque.style.top = pos + 'px';
    ajax = nuevoAjax2();
    ajax.open("GET", "popup/verinfoh.php?i=" + id, true);
    var afecta;

    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4) {
            results = ajax.responseText.split("|<");
            document.getElementById('nombre').innerHTML = results[0];
            document.getElementById('valor').innerHTML = results[1];
            document.getElementById('descripcion').innerHTML = results[2];
            
            switch (results[3]){
            	case '1':
            		afecta="Usuarios";
            		break;
            	case '2':
            		afecta="Npcs";
            		break;
            	case '3':
            		afecta="Usuarios y npc";
            		break;
            	case '4':
            		afecta="Terreno";
            		break;
            	default:
            		afecta="?";
            		break;
        		}
            document.getElementById('afecta').innerHTML = afecta;
            document.getElementById('skill').innerHTML = results[4];
            document.getElementById('manar').innerHTML = results[5];
            document.getElementById('star').innerHTML = results[6];
            var clases = "";
            var i;
            for (i = 7; i < results.length; i++) { if (results[i].length > 0) { if (clases != 0) clases += ", ";
                    clases = clases + results[i]; } }
            clases = clases + '.';
            document.getElementById('clasesp').innerHTML = clases;
        }
    }
    ajax.send(null);
    return false;
}

function verobjeto(id) {
    var i;
    var bloque;
    ocultarhechizo();
    document.getElementById('i_nombre').innerHTML = "Cargando...";
    document.getElementById('i_desc').innerHTML = "Cargando...";
    bloque = document.getElementById('info_item');
    bloque.style.display = 'block';
    if (window.innerHeight) { pos = window.pageYOffset } else if (document.documentElement && document.documentElement.scrollTop) { pos = document.documentElement.scrollTop } else if (document.body) { pos = document.body.scrollTop }
    if (pos < theTop)
        pos = theTop;
    else
        pos += 30;
    bloque.style.top = pos + 'px';
    ajax = nuevoAjax2();
    ajax.open("GET", "popup/verinfo.php?i=" + id, true);
    ajax.onreadystatechange = function() { if (ajax.readyState == 4) { results = ajax.responseText.split("|<");
            document.getElementById('i_nombre').innerHTML = results[0];
            document.getElementById('i_desc').innerHTML = results[1]; var clases = ""; var i; for (i = 7; i < results.length; i++) { if (results[i].length > 0) { if (clases != 0) clases += ", ";
                    clases = clases + results[i]; } } } }
    ajax.send(null);
    return false;
}

function emergente(nombre) {
    var i;
    var bloque;
    document.getElementById('e_titulo').innerHTML = "Cargando...";
    document.getElementById('e_contenido').innerHTML = "Cargando...";
    bloque = document.getElementById('divemergente');
    bloque.style.display = 'block';
    if (window.innerHeight) { pos = window.pageYOffset } else if (document.documentElement && document.documentElement.scrollTop) { pos = document.documentElement.scrollTop } else if (document.body) { pos = document.body.scrollTop }
    if (pos < theTop)
        pos = theTop;
    else
        pos += 30;
    bloque.style.top = pos + 50 + 'px';
    ajax = nuevoAjax2();
    ajax.open("GET", "manual/emer" + nombre + ".php?", true);
    ajax.onreadystatechange = function() { if (ajax.readyState == 4) { results = ajax.responseText.split("|<");
            document.getElementById('e_titulo').innerHTML = results[0];
            document.getElementById('e_contenido').innerHTML = results[1]; } }
    ajax.send(null);
    return false;
}