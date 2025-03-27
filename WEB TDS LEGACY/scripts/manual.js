var _____WB$wombat$assign$function_____ = function(name) { return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name)) || self[name]; };
if (!self.__WB_pmw) { self.__WB_pmw = function(obj) { this.__WB_source = obj; return this; } } {
    let window = _____WB$wombat$assign$function_____("window");
    let self = _____WB$wombat$assign$function_____("self");
    let document = _____WB$wombat$assign$function_____("document");
    let location = _____WB$wombat$assign$function_____("location");
    let top = _____WB$wombat$assign$function_____("top");
    let parent = _____WB$wombat$assign$function_____("parent");
    let frames = _____WB$wombat$assign$function_____("frames");
    let opener = _____WB$wombat$assign$function_____("opener");

    var ajax = null;
    var anterior = new Array(null, null, null, null);

    function nuevoAjax() {
        var xmlhttp = false;
        try {
            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (E) {
                xmlhttp = false;
            }
        }

        if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
            xmlhttp = new XMLHttpRequest();
        }
        return xmlhttp;
    }

    function ver(objeto, linea, menu) {
        // ---- SELECCIONAR SECCION ---- //
        var submenu = document.getElementById('submenu' + linea);
        if (objeto.className == "bg_seccion_r link_off") {
            //PONGO LAS FLECHITAS Y PRENDO EL BOTON =)
            objeto.className = "bg_seccion_r link_on";
            // MUESTRO EL SUBMENU
            submenu.style.display = "";
            // OBTENGO LOS SUBMENUES
            ajax = nuevoAjax();
            ajax.open("GET", "manual/" + linea + "." + menu + ".html");
            ajax.onreadystatechange = function() {
                if (ajax.readyState == 4) {
                    submenu.innerHTML = ajax.responseText;
                }
            }
            ajax.send(null);
            // ------------------------
            //DESACTIVO EL ANTERIOR
            if (anterior[linea] != null) {
                anterior[linea].className = "bg_seccion_r link_off";
            }
            anterior[linea] = objeto;
        } else {
            //SI SE TOCA SOBRE EL MISMO BOTON Y ESTE ESTA PRENDIDO LO APAGO
            objeto.className = "bg_seccion_r link_off";
            submenu.style.display = "none";
            anterior[linea] = null;
        }

        return false;
    }

}