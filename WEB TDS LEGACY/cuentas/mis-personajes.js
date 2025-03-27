function nuevoAjax(){
	var xmlhttp=false;
 	try {
 		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
 	} catch (e) {
 		try {
 			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
 		} catch (E) {
 			xmlhttp = false;
 		}
  	}

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
 		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}

function request(url, data, callback) {
	var xhr = new XMLHttpRequest();
	xhr.open('POST', url, true);
	var loader = document.createElement('div');
	loader.className = 'loader';
	document.body.appendChild(loader);
	xhr.addEventListener('readystatechange', function() {
		if(xhr.readyState === 4) {
			if(callback) {
				callback(xhr.response);
			}
			loader.remove();
		}
	});

	var formdata = data ? (data instanceof FormData ? data : new FormData(document.querySelector(data))) : new FormData();

	var csrfMetaTag = document.querySelector('meta[name="csrf_token"]');
	if(csrfMetaTag) {
		formdata.append('csrf_token', csrfMetaTag.getAttribute('content'));
	}

	xhr.send(formdata);
}

function desloguear(nick) {

	var label;
	var labelstatus;
		
		ajax = nuevoAjax();
		label= document.getElementById('l'+nick);
		contenedor = document.getElementById("m_BETATESTER");
		
		labelstatus= document.getElementById('log');

		label.innerHTML = "Deslogueando"
		ajax.open("POST", "/cuentas/mis_personajes/a_echarPersonaje.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("nick="+nick);
		
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = parseInt(ajax.responseText);						
					switch (respuesta) {
						case 0: case 8:

							var brElement = label.previousElementSibling;
							if (brElement && brElement.tagName === "BR") {
								contenedor.removeChild(brElement);
							}
							
							label.remove();
							labelstatus.innerHTML ="Offline";
							labelstatus.style.color = '';
							break;							
						case 1:
							label.innerHTML="Nick equivocado";
							break;
						case 2:
							label.innerHTML="Cuenta equivocada."; 
							break;
						case 3:
							label.innerHTML="Cuenta equivocada."; 
							break;
						case 4:
							label.innerHTML="Alguno de los datos son incorrectos."; 
							break;
						case 5:
							label.innerHTML="Alguno de los datos son incorrectos.";
							break;
						case 6:
							label.innerHTML="Cuenta equivocada.";
							break;
						case 7:
							label.innerHTML="El personaje está paralizado.";
							break;
						default:
							var brElement = label.previousElementSibling;
							if (brElement && brElement.tagName === "BR") {
								contenedor.removeChild(brElement);
							}							
							label.remove();
							alert("Error:" + ajax.responseText);
							break;
					}
		}
		
		return false;

	}
}

function recuperarpj(nick) {

	label= document.getElementById('r'+nick);
	label.innerHTML = "Aguarde.."

	document.getElementById('r'+nick).style.pointerEvents = 'none';
	document.getElementById('r'+nick).removeAttribute('onClick');

	request('/php/passwordResetRequest.php', '#m_' + nick, function(data) {
		
		try { 
			data = JSON.parse(data);
			
			if(!(data instanceof Array)) {throw Exception('bad data');}
			
			for(var i = 0;i < data.length;++i) {
				switch(data[i]) {
					case 0:
							label.innerHTML = "¡Revisa tu correo!";break;							
						case 1:
							label.innerHTML="Error al enviar mail";break;
						case 2:
							label.innerHTML="DB Connect";break;
						case 3:
							label.innerHTML="Exediste el numero de peticiones de reset diarios!";break;
						case 4:
							label.innerHTML="DB Error!";break;
						case 5:
							label.innerHTML="Refresca la pagina.";break;
						case 6:
							label.innerHTML="Email invalido.";break;
						case 7:
							label.innerHTML="No me pude conectar con el servidor.";break;
						case 8:
							label.innerHTML="Email invalido";break;
						case 9:
							label.innerHTML="Nick invalido o inexistente.";break;
						default:
							label.remove();
							alert(ajax.responseText);break;
				}
			}
		}
		catch(e) {
			label.innerHTML = 'El servidor se encuentra APAGADO';
		}		
	});

}

function agregarpj() {

	var label;
	var nick = document.getElementById("nick").value;
	var pass = document.getElementById("pass").value;
	var pin = document.getElementById("pin").value;

	ajax = nuevoAjax();
	label= document.getElementById('response');
	
	label.innerHTML = "Aguarde.."
	ajax.open("POST", "/cuentas/mis_personajes/a_agregarPersonajeCuenta.php");
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("nick="+nick + "&pass="+pass+"&pin="+pin);
	
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {

					var respuesta = parseInt (ajax.responseText);
					label.style="color:FF0000;margin:10px;";
					
					switch (respuesta) {
						case 0:
							label.innerHTML = "Personaje agregado!";
							label.style="color:008000;margin:10px;";
							document.getElementById('Submit').remove();
							break;							
						case 2:
							label.innerHTML="Nick invalido!";break;
						case 3:
							label.innerHTML="Personaje inexistente o datos equivocados!"; break;
						case 4:
							label.innerHTML="El personaje se encuentra baneado!";break;
						case 5:
							label.innerHTML="Ya se encuentra en una cuenta";break;
						case 6:
							label.innerHTML="Numero de cuenta inválido!";break;
						case 7:
							label.innerHTML="No puedes agregar más personajes a tu cuenta! (max=15)";break;
						case 10:
							label.innerHTML="No puedes agregar más personajes a tu cuenta! (max=3)";break;
						default:
							label.innerHTML="Error: "+ajax.responseText;
							break;
					}
		}
		
		return false;

	}
}


function quitarpj() {

	var label;
	var nick = document.getElementById("nick").value;
	var pass = document.getElementById("pass").value;
	var pin = document.getElementById("pin").value;

	ajax = nuevoAjax();
	label= document.getElementById('response');
	
	label.innerHTML = "Aguarde.."
	ajax.open("POST", "/cuentas/mis_personajes/a_quitarPersonaje.php");
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("nick="+nick + "&pass="+pass+"&pin="+pin);
	
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {

					var respuesta = parseInt (ajax.responseText);
					label.style="color:FF0000;margin:10px;";
					
					switch (respuesta) {
						case 0:
							label.innerHTML = "Personaje removido!";
							label.style="color:008000;margin:10px;";
							
							document.getElementById('Submit').remove();
							break;							
						case 2:
							label.innerHTML="Personaje inexistente o datos equivocados!";
							break;
						case 3:
							label.innerHTML="Personaje inexistente o datos equivocados!"; 
							break;
						case 4:
							label.innerHTML="El personaje se encuentra baneado!"; 
							break;
						case 5:
							label.innerHTML="Numero de cuenta inválido"; 
							break;
						case 6:
							label.innerHTML="Ya se encuentra en una cuenta!";
							break;
						case 7:
							label.innerHTML="Alguno de los datos son incorrectos";
							break;
						case 8:
							label.innerHTML="Alguno de los datos son incorrectos";
							break;
						case 9:
							label.innerHTML="No tienes pjs!";
							break;
						case 10:
							label.innerHTML="No te pertenece!";
							break;
						default:
							label.innerHTML="Error: "+ajax.responseText;
							break;
					}
		}
		
		return false;

	}
}

function bloquear(nick) {
	
	var pin = prompt('Introduce el PIN de la cuenta','');
	
	if (pin != null) {
		var label;
		var antiguo;
		ajax = nuevoAjax();
		
		antiguo= document.getElementById('b'+nick).innerHTML;
		label = document.getElementById('b'+nick);
		label.innerHTML = "Espere..."
		ajax.open("POST", "/cuentas/mis_personajes/a_bloquearPersonaje.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("pin="+encodeURIComponent(pin)+"&nick="+nick);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					
					var respuesta = parseInt (ajax.responseText);
										
					switch (respuesta) {
						case 0:
							alert("El personaje "+nick+" fue desbloqueado");
							label.innerHTML = "Bloquear";
							break;
						case 1:
							alert("Error: Personaje inexistente.");
							label.innerHTML = antiguo;
							break;
						case 2:
							alert("El personaje no pertenece a tu cuenta.");
							label.innerHTML = antiguo;
							break;
						case 3: // ya estaba offline
							alert("El personaje esta ONLINE. Para bloquear es necesario que el personaje se encuentre Offline. Para echar al personaje del juego hace click en 'Desloguear.'");
							label.innerHTML= antiguo;
							break;
						case 4:
							alert("El personaje "+nick+" fue bloqueado");
							label.innerHTML = "Desbloquear";
							break;	
						case 5:
							alert("El PIN ingresado no corresponde al personaje "+nick);
							label.innerHTML = antiguo;
							break;
						case 6:
							alert("Para poder utilizar esta funcion deberas acreditar tiempo premium en tu cuenta.");
							label.innerHTML = antiguo;
							break;
						case 7:
							alert("No es posible realizar esta opción en estos momentos. Por favor, intenta en unos minutos.");
							label.innerHTML = antiguo;
							break;
						default:
							label.innerHTML = ajax.responseText;
							break;			
					}
				}
		}
		
		
	}
	
	return false;
}