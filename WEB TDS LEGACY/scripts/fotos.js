var maximg = 5;
var actnum = "";
var valoracion = 0;
var categoria = new Array(1);
categoria[0] = 'Todas';

function con(id) { document.getElementById('pj0').className = "";
    document.getElementById('pj1').className = "";
    document.getElementById('pj2').className = "";
    document.getElementById('pj3').className = "";
    document.getElementById('pj4').className = "";
    document.getElementById('pj' + id).className = "activa"; }

function nuevoAjax() {
    var xmlhttp = false;
    try { xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) {
        try { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); } catch (E) { xmlhttp = false; }
    }
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') { xmlhttp = new XMLHttpRequest(); }
    return xmlhttp;
}

function verimagen(num) {
    var theTop = 30;
    var imagen = document.getElementById('imagengrande');
    imagen.innerHTML = '<img src="/screens/' + num + '.jpg"  title="Click aquí para cerrar la imagen" border="1"/>';
    var bloque;
    bloque = document.getElementById('imagengrande');
    bloque.style.display = 'block';
    if (window.innerHeight) { pos = window.pageYOffset } else if (document.documentElement && document.documentElement.scrollTop) { pos = document.documentElement.scrollTop } else if (document.body) { pos = document.body.scrollTop }
    if (pos < theTop)
        pos = theTop;
    else
        pos += 30;
    bloque.style.top = pos + 'px';
    return false;
}

function ocultar() { document.getElementById('imagengrande').style.display = "none"; }

function setStars(num) { ajax = nuevoAjax();
    ajax.open("POST", "/screens/vot.php");
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("rank=" + num + "&foto=" + actnum);
    ajax.onreadystatechange = function() { if (ajax.readyState == 4) { document.getElementById('valoracion').innerHTML = ajax.responseText; } } }

function clearStars() { var k = 1;
    document.getElementById('vota-1').style.display = "none";
    document.getElementById('vota-2').style.display = "none";
    document.getElementById('vota-3').style.display = "none";
    document.getElementById('vota-4').style.display = "none";
    document.getElementById('vota-5').style.display = "none"; for (k = 1; k < 6; k++) { document.getElementById("vota-" + k + "").style.display = ""; } }

function showStars(num) { var k = 1;
    document.getElementById('vota-1').style.display = "none";
    document.getElementById('vota-2').style.display = "none";
    document.getElementById('vota-3').style.display = "none";
    document.getElementById('vota-4').style.display = "none";
    document.getElementById('vota-5').style.display = "none"; for (k = 1; k < num + 1; k++) { document.getElementById("vota-" + k + "").style.display = ""; } }

function show(num) {
    ocultar();
    if (actnum != num) {
        actnum = num;
        document.getElementById('descripcion').innerHTML = '<p>Cargando..<img src="/cargando.gif" alt="Cargando..." /></p>';
        document.getElementById('nombre_foto').innerHTML = 'Cargando..';
        var imagen = document.getElementById('imagen');
        imagen.innerHTML = '<a href="#" title = "Ver imagen en tamaño real" onclick="return verimagen(\'' + num + '\')" ><img src="/screens/' + num + '.jpg" width="556" height="417" border="0"/></a>';
        ajax = nuevoAjax();
        ajax.open("GET", "/screens/ajax2.php?from=" + num, true);
        ajax.onreadystatechange = function() {
            if (ajax.readyState == 4) {
                var resultado = ajax.responseText.split("<|>");
                document.getElementById('descripcion').innerHTML = '<p>' + resultado[1] + '</p>';
                document.getElementById('vista').innerHTML = resultado[2] + ' veces';
                document.getElementById('categoria').innerHTML = categoria[parseInt(resultado[3])];
                document.getElementById('nombre_foto').innerHTML = resultado[4];
                document.getElementById('usuario').innerHTML = resultado[5];
                document.getElementById('valoracion').innerHTML = resultado[6];
                document.getElementById('fecha').innerHTML = resultado[7];
                //valoracion = resultado[8];
                //var ajax2 = nuevoAjax();
                //ajax2.open("GET", "comentarios/control.php?id=" + parseInt(resultado[9])), true);
                //ajax2.onreadystatechange = function() { if (ajax2.readyState == 4) { document.getElementById('comentarios').innerHTML = ajax2.responseText; } }
                //ajax2.send(null);
            }
        }
        ajax.send(null);
    }
}

function move(num) {
    ocultar();
    ajax = nuevoAjax();
    if (num == 0) { antres = 0; } else if (num == 2) { antres += 5; } else if (num = 1) { antres -= 5; }
    if (antres <= 0) { antres = 0;
        document.getElementById('f_izq').innerHTML = ''; } else { document.getElementById('f_izq').innerHTML = '<a href="javascript:move(1)"></a>'; }
    ajax.open("GET", "/screens/ajax.php?from=" + antres, true);
    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4) {
            var results = ajax.responseText.split("|");
            if (num == 0) { show(results[0]); }
            var i = 0;
            var pj;
            var b;
            var z;
            if (num == 2) {
                i = 0;
                var atras = 0;
                for (b = 4; b >= 0; b--) {
                    pj = document.getElementById('pj' + 4);
                    if (results[0 + i * 2] != 0) {
                        for (z = 0; z < 4; z++) { document.getElementById('pj' + (z)).innerHTML = document.getElementById('pj' + (z + 1)).innerHTML; }
                        pj.innerHTML = '<a href="javascript:show(\'' + results[0 + i * 2] + '\')"><img src="/screens/' + results[0 + i * 2] + 't.jpg" alt="' + results[1 + i * 2] + '"  border="0"/></a>';
                    } else { document.getElementById('f_der').innerHTML = ''; }
                    i++;
                }
            } else {
                for (i = 0; i <= 4; i++) {
                    pj = document.getElementById('pj' + i);
                    if (results[0 + i * 2] != 0) { pj.innerHTML = '<a href="javascript:show(\'' + results[0 + i * 2] + '\')"><img src="/screens/' + results[0 + i * 2] + 't.jpg" alt="' + results[1 + i * 2] + '" border="0"/></a>'; }
                    document.getElementById('f_der').innerHTML = '<a href="javascript:move(2)"></a>';
                }
            }
        }
    }
    ajax.send(null);
    document.getElementById('pj0').className = "";
    document.getElementById('pj1').className = "";
    document.getElementById('pj2').className = "";
    document.getElementById('pj3').className = "";
    document.getElementById('pj4').className = "";
}