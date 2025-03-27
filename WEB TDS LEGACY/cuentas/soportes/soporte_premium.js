function validarpremium() {
	var mensaje = "";

	if (document.getElementById("nick").value == "") {
		mensaje += "- Tenés que completar tu nick\n";
	}

	if (document.getElementById("sector").selectedIndex == 0) {
		mensaje += "- Tenés que seleccionar el sector que corresponda\n";
	}

	if (document.getElementById("asunto").value == "") {
		mensaje += "- Tenés que completar el asunto\n";
	}

	if (document.getElementById("mensaje").value == "") {
		mensaje += "- Tenés que completar el mensaje\n";
	}

	if (mensaje == "") {
		return true;
	} else {
		alert(mensaje);
		return false;
	}
}

function rr(tipo) {

var txt=document.getElementById('txt_alerta');
var tabla=document.getElementById('alerta');
	if (tipo=='Problema Técnico') {
		txt.innerHTML = '<img src="imagenes/alert_tds.gif" alt="" /><p>Antes de mandar soporte revisa <a href="https://web.archive.org/web/20130124065029/http://foroaotds.localstrike.com.ar/foro/showpost.php?p=306569&amp;postcount=4">aqui<\/a>, donde se solucionan los problemas mas comunes que le surgen a los usuarios</p>';
	} else if (tipo=='Robo De Personaje') {
		txt.innerHTML = '<img src="imagenes/alert_tds.gif" alt="" /><p>El Staff <b>NO<\/b> se hace responsable del robo de personajes. Para recuperar tu personaje intenta lo siguiente:</p><p>- Si te robaron el mail manda unn soporte a la empresa proveedora del mismo. Tienes un ejemplo aqui.</p><p>- Si te robaron el personaje recupera la password desde la pagina principal.</p>';
	} else if (tipo=='Denuncia') {
		txt.innerHTML ='<img src="imagenes/alert_tds.gif" alt="" /><p>Para que el staff pueda investigar de una mánera rápida y efectiva necesitamos que ingreses la mayor cantidad posible de información sobre el hecho que denuncias. Nombre del gm involucrado. fecha/hora y acto realizado son fundamentales.</p>';
	} else {
		tabla.style.display = 'none';
		return false;
	}
	tabla.style.display = 'block';
	return false;
}
