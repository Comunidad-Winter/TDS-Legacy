function validar() {
	var mensaje = "";

	if (document.getElementById("nombre").value == "") {
		mensaje += "- Tenes que completar tu nombre\n";
	}

	if (document.getElementById("nick").value == "") {
		mensaje += "- Tenes que completar tu nick\n";
	}

	if (document.getElementById("email").value == "") {
		mensaje += "- Tenes que completar tu e-mail\n";
	} else if (document.getElementById("email").value != document.getElementById("confirmEmail").value) {
		mensaje += "- El mail que ingresaste, no coincide con la verificacion\n";
	}

	if (document.getElementById("sector").selectedIndex == 0) {
		mensaje += "- Tenes que seleccionar el sector que corresponda\n";
	}

	if (document.getElementById("asunto").value == "") {
		mensaje += "- Tenes que completar el asunto\n";
	}

	if (document.getElementById("mensaje").value == "") {
		mensaje += "- Tenes que completar el mensaje\n";
	}

	if (document.getElementById("captcha").value == "") {
		mensaje += "- Tenes que completar el resultado de la cuenta\n";
	}

	if (mensaje == "") {
		document.forms[1].submit();
	} else {
		alert(mensaje);
	}
}

function buscarSoporte() {
	var mensaje = "";

	if (document.getElementById("buscarEmail").value == "") {
		mensaje += "- Tenes que completar el email\n";
	}

	if (document.getElementById("buscarTicket").value == "") {
		mensaje += "- Tenes que completar el numero de Ticket\n";
	}

	if (mensaje == "") {
		document.forms[0].submit();
	} else {
		alert(mensaje);
	}
}


function enviarPost(cerrar) {
	mensaje = "";
	if (document.getElementById("mensaje").value == "" && cerrar !== true) {
		mensaje += "- Tenes que completar el mensaje\n";
		alert(mensaje);
	} else {
		if (cerrar === true) {
			document.getElementById("cerrar").value = "S";
		} else {
			document.getElementById("cerrar").value = "N";
		}

		document.forms[0].submit();
	} 
}

function rr(tipo) {

txt=document.getElementById('txt_alerta');
tabla=document.getElementById('alerta');
	if (tipo=='ProblemaTecnico') {
		txt.innerHTML = '<img src="/imagenes/alert_tds.gif" alt="" /><p>Antes de mandar soporte revisa <a href="http://foro.tdslegacy.com/foro/showpost.php?p=306569&amp;postcount=4">aqui<\/a>, donde se solucionan los problemas mas comunes que le surgen a los usuarios</p>';
	} else if (tipo=='RoboDePersonaje') {
		txt.innerHTML = '<img src="/imagenes/alert_tds.gif" alt="" /><p>El Staff <b>NO<\/b> se hace responsable del robo de personajes. Para recuperar tu personaje intenta lo siguiente:</p><p>- Si te robaron el mail manda unn soporte a la empresa proveedora del mismo. Tienes un ejemplo aqui.</p><p>- Si te robaron el personaje recupera la password desde la pagina principal.</p>';
	} else if (tipo=='Denuncia') {
		txt.innerHTML ='<img src="/imagenes/alert_tds.gif" alt="" /><p>Para que el staff pueda investigar de una manera rapida y efectiva necesitamos que ingreses la mayor cantidad posible de información sobre el hecho que denuncias. Nombre del gm involucrado. fecha/hora y acto realizado son fundamentales.</p>';
	} else {
		tabla.style.display = 'none';
		return false;
	}
	tabla.style.display = 'block';
	return false;
}
