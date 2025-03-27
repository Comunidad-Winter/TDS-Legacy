
// global functions
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

// index.php
function logout() {
	request('/php/logout.php', false, function(data) {
		if(data === '0') {
			window.location = 'login';
		}
	});
}

function login() {
	request('/php/login.php', '#login-cuenta', function(data) {
		document.getElementById('errs').innerHTML = "";
		var transition = document.getElementById('errs').style.transition;
		document.getElementById('errs').style.transition = "none";
		document.getElementById('errs').style.opacity = 0;
		switch(data) {
			case '0':
				window.location = '/cpremium.php';
				break;
			case '1':
				alert( 'Nombre o contraseña incorrecto.');
				break;
			case '2':
				alert('Error en la conexion con la base de datos. Por favor intente mas tarde.');
				break;
			case '3':
				alert('Excediste los intentos de logueo. Prueba en una hora.');
				break;
			case '4':
				document.getElementById('errs').innerHTML += 'Tu email no fue validado. Por favor revisar tu correo para activar tu cuenta o <a href="/validate">clickea aca</a> para enviar otro link';
				break;
			default:
				alert('An unknown error occurred. Por favor intente mas tarde.');
		}
		setTimeout(function() {
			document.getElementById('errs').style.transition = transition;
			document.getElementById('errs').style.opacity = 1;
		}, 10);
	});
}

// register.php
function register() {
	request('/php/register.php', '#cuentasPremium', function(data) {
		document.getElementById('errs').innerHTML = "";
		var transition = document.getElementById('errs').style.transition;
		document.getElementById('errs').style.transition = "none";
		document.getElementById('errs').style.opacity = 0;
		try {
			
			console.log(JSON.parse(data));

			data = JSON.parse(data);
			if(!(data instanceof Array)) {throw Exception('bad data');}

			//Show errors to user
			for(var i = 0;i < data.length;++i) {
				switch(data[i]) {
					case 0:
						alert('Tu cuenta ha sido creada! Por favor valida tu email con el link que te enviamos a tu correo antes de conectarte.');
						window.location = '/cuenta-premium.php';
						break;
					case 1:
						document.getElementById('errs').innerHTML += '<div class="err">Nombre ingresado invalido. (usa solo letras, espacios y numeros)</div>';
						break;
					case 2:
						document.getElementById('errs').innerHTML += '<div class="err">Email ingresado invalido.</div>';
						break;
					case 3:
						document.getElementById('errs').innerHTML += '<div class="err">Email ingresado invalido. (Este dominio no tiene un mail-server)</div>';
						break;
					case 4:
						document.getElementById('errs').innerHTML += '<div class="err">La contraseña debe tener al menos 3 caracteres</div>';
						break;
					case 5:
						document.getElementById('errs').innerHTML += '<div class="err">Las contraseñas no coiniciden. Por favor re-ingresa tu contraseña.</div>';
						break;
					case 6:
						document.getElementById('errs').innerHTML += '<div class="err">Error al insertar en la base de datos. Por favor intenta mas tarde.</div>';
						break;
					case 7:
						document.getElementById('errs').innerHTML += '<div class="err">Ya hay una cuenta asociada a ese mail o nick</div>';
						break;
					case 8:
						document.getElementById('errs').innerHTML += '<div class="err">Error al conectar con la base de datos. Intentelo mas tarde.</div>';
						break;
					case 9:
						document.getElementById('errs').innerHTML += '<div class="err">Token CSRF inválido. Intentelo mas tarde.</div>';
						break;
					case 10:
						document.getElementById('errs').innerHTML += '<div class="err">Error al enviar el mail. Intentelo mas tarde.</div>';
						break;
					case 11:
						document.getElementById('errs').innerHTML += '<div class="err">Error al insertar en la base de datos x2. Intentelo mas tarde.</div>';
						break;
					case 12:
						document.getElementById('errs').innerHTML += '<div class="err">Excediste el numero maximo de solicitudes por dia</div>';
						break;
					case 13:
						document.getElementById('errs').innerHTML += '<div class="err">Este usuario ya esta validado</div>';
						break;
					case 14:
						document.getElementById('errs').innerHTML += '<div class="err">Usuario inexistente</div>';
						break;
					case 15:
						document.getElementById('errs').innerHTML += '<div class="err">Failed to connect to database. Intentelo mas tarde.</div>';
						break;				
					case 16:
						document.getElementById('errs').innerHTML += '<div class="err">Error al contactar con el servidor del AO. Intentelo mas tarde.</div>';
						break;
					case 17:
						document.getElementById('errs').innerHTML += '<div class="err">Nombre personal invalido.</div>';
						break;
					case 18:
						document.getElementById('errs').innerHTML += '<div class="err">Apellido personal invalido.</div>';
						break;
					case 19:
						document.getElementById('errs').innerHTML += '<div class="err">Pin invalido. (usa solo letras y numeros)</div>';
						break;
					case 20:
						document.getElementById('errs').innerHTML += '<div class="err">No me pude conectar con el servidor, la cuenta si o si se puede crear si el server está ON!!!</div>';
						break;
					default:
						document.getElementById('errs').innerHTML += '<div class="err">Ha ocurrido un error desconocido. Intentelo mas tarde.</div>' + data[i];
				}
			}
		}
		catch(e) {
			alert('El servidor no se encuentra abierto, imposible crear cuenta.');
		}
		setTimeout(function() {
			document.getElementById('errs').style.transition = transition;
			document.getElementById('errs').style.opacity = 1;
		}, 2);
	});
}

// validateEmail.php
function sendValidateEmailRequest() {
	request('/php/sendValidationEmail.php', '#validateEmailForm', function(data) {
		document.getElementById('errs').innerHTML = "";
		var transition = document.getElementById('errs').style.transition;
		document.getElementById('errs').style.transition = "none";
		document.getElementById('errs').style.opacity = 0;

		switch(data) {
			case '0':
				alert('Email enviado... Revisa tu correo y clickea en el enlace para validar tu cuenta.');
				window.location = '/cuenta-premium.php';
				break;
			case '1':
				document.getElementById('errs').innerHTML += '<div class="err">Error al enviar el mail. Por favor intentelo mas tarde.</div>';
				break;
			case '2':
				document.getElementById('errs').innerHTML += '<div class="err">Error al insertar en la base de datos. Por favor intentelo mas tarde.</div>';
				break;
			case '3':
				document.getElementById('errs').innerHTML += '<div class="err">Exediste el limite de intentos por día</div>';
				break;
			case '4':
				document.getElementById('errs').innerHTML += '<div class="err">Ya se ha validado esta cuenta!!</div>';
				break;
			case '5':
				document.getElementById('errs').innerHTML += '<div class="err">No hay ninguna cuenta asociada a ese mail.</div>';
				break;
			case '6':
				document.getElementById('errs').innerHTML += '<div class="err">Error al conectarse con la base de datos. Por favor intentelo mas tarde.</div>';
				break;
			default:
				document.getElementById('errs').innerHTML += '<div class="err">Un error desconocido ha ocurrido. Notifica esto a los GM.</div>';
		}
		setTimeout(function() {
			document.getElementById('errs').style.transition = transition;
			document.getElementById('errs').style.opacity = 1;
		}, 10);
	});
}

function passwordResetRequest() {
	request('/php/passwordResetRequest.php', '#form_recu_pass', function(data) {
		document.getElementById('errs').innerHTML = "";
		var transition = document.getElementById('errs').style.transition;
		document.getElementById('errs').style.transition = "none";
		document.getElementById('errs').style.opacity = 0;

		switch(data) {
			case '0':
				alert('Un email ha sido enviado! Revisa tu correo');
				window.location = '/index.php';
				break;
			case '1':
				document.getElementById('errs').innerHTML += '<div class="err">Error al enviar el mail. Intenta mas tarde.</div>';
				break;
			case '2':
				document.getElementById('errs').innerHTML += '<div class="err">Error al insertar en DB. Intenta mas tarde.</div>';
				break;
			case '3':
				document.getElementById('errs').innerHTML += '<div class="err">Exediste el numero de peticiones de reset diarios!! Intenta mas tarde.</div>';
				break;
			case '4':
				document.getElementById('errs').innerHTML += '<div class="err">No me pude conectar a la DB. Intenta mas tarde.</div>';
				break;
			case '5':
				document.getElementById('errs').innerHTML += '<div class="err">Refrezca la página!</div>';
				break;
			case '6':
				document.getElementById('errs').innerHTML += '<div class="err">Email invalido</div>';
				break;
			case '7':
				document.getElementById('errs').innerHTML += '<div class="err">No me pude conectar con el servidor.</div>';
				break;
			case '8':
				document.getElementById('errs').innerHTML += '<div class="err">Email invalido.</div>';
				break;
			case '9':
				document.getElementById('errs').innerHTML += '<div class="err">Nick invalido o inexistente.</div>';
				break;
			default:
				document.getElementById('errs').innerHTML += '<div class="err">Error desconocido: ' +  data + '</div>';
		}
		setTimeout(function() {
			document.getElementById('errs').style.transition = transition;
			document.getElementById('errs').style.opacity = 1;
		}, 10);
	});
}

function changePassword() {

	request('/php/passwordResetRequest2.php', '#cuentasPremium', function(data) {
		document.getElementById('errs').innerHTML = "";
		var transition = document.getElementById('errs').style.transition;
		document.getElementById('errs').style.transition = "none";
		document.getElementById('errs').style.opacity = 0;
		try { 
			data = JSON.parse(data);
			
			if(!(data instanceof Array)) {throw Exception('bad data');}
			
			//Show errors to user
			for(var i = 0;i < data.length;++i) {
				switch(data[i]) {
					case 0:
						document.getElementById('errs').innerHTML += '<div>Tu contraseña ha sido reseteado! Puedes loguear <a href="/cuenta-premium.php">aca</a></div>';
						document.getElementById('cuentasPremium').reset();
						break;
					case 1:
						document.getElementById('errs').innerHTML += '<div class="err">La cuenta no existe!</div>';
						break;
					case 2:
						document.getElementById('errs').innerHTML += '<div class="err">El email es demasiado corto o demasiado largo.</div>';
						break;
					case 3:
						document.getElementById('errs').innerHTML += '<div class="err">El email es invalido.</div>';
						break;
					case 4:
						document.getElementById('errs').innerHTML += '<div class="err">La cuenta solicitada no existe</div>';
						break;
					case 5:
						document.getElementById('errs').innerHTML += '<div class="err">La nueva contraseña es muy larga?</div>';
						break;
					case 6:
						document.getElementById('errs').innerHTML += '<div class="err">Error al actualizar la DB. Intenta mas tarde.</div>';
						break;
					case 7:
						document.getElementById('errs').innerHTML += '<div class="err">Este link expiró.</div>';
						break;
					case 8:
						document.getElementById('errs').innerHTML += '<div class="err">Error al conectar con la DB. Intenta mas tarde.</div>';
						break;
					case 9:
						document.getElementById('errs').innerHTML += '<div class="err">Token CSRF invalido. Intenta mas tarde.</div>';
						break;
					case 10:
						document.getElementById('errs').innerHTML += '<div class="err">No me pude conectar con el servidor.</div>';
						break;
					case 11:
						document.getElementById('errs').innerHTML += '<div class="err">Contraseña nueva invalida.</div>';
						break;
					case 12:
						document.getElementById('errs').innerHTML += '<div class="err">Las contraseñas no coinciden.</div>';
						break;
					case 13:
						document.getElementById('errs').innerHTML += '<div class="err">Invalid input.</div>';
						break;
					default:
						document.getElementById('errs').innerHTML += '<div class="err">Error desconocido. Intenta mas tarde.</div>';
				}
			}
		}
		catch(e) {
			document.getElementById('errs').innerHTML = '<div class="err">El servidor se encuentra APAGADO!</div>';
		}
		setTimeout(function() {
			document.getElementById('errs').style.transition = transition;
			document.getElementById('errs').style.opacity = 1;
		}, 10);
	});
}

function changePasswordAccount() {

	request('/php/passwordResetRequest3.php', '#cuentasPremium', function(data) {
		document.getElementById('errs').innerHTML = "";
		var transition = document.getElementById('errs').style.transition;
		document.getElementById('errs').style.transition = "none";
		document.getElementById('errs').style.opacity = 0;
		try { 
			data = JSON.parse(data);
			
			if(!(data instanceof Array)) {throw Exception('bad data');}
			
			//Show errors to user
			for(var i = 0;i < data.length;++i) {
				switch(data[i]) {
					case 0:
						document.getElementById('errs').innerHTML += '<div>Tu contraseña ha sido reseteado! Puedes loguear <a href="/cuenta-premium.php">aca</a></div>';
						document.getElementById('cuentasPremium').reset();
						break;
					case 1:
					case 2:
					case 7:
						document.getElementById('errs').innerHTML += '<div class="err">Solicitud de reseteo de pass invalido. Si crees que es un error vuelve a solicitar otro.</div>';
						break;
					case 3:
						document.getElementById('errs').innerHTML += '<div class="err">La contraseña debe tener: <ul><li>Al menos 6 letras</li></ul></div>';
						break;
					case 4:
						document.getElementById('errs').innerHTML += '<div class="err">Las contraseñas no coinciden.</div>';
						break;
					case 5:
						document.getElementById('errs').innerHTML += '<div class="err">Error al actualizar la DB. Intenta mas tarde.</div>';
						break;
					case 6:
						document.getElementById('errs').innerHTML += '<div class="err">Este link expiró.</div>';
						break;
					case 8:
						document.getElementById('errs').innerHTML += '<div class="err">Error al conectar con la DB. Intenta mas tarde.</div>';
						break;
					case 9:
						document.getElementById('errs').innerHTML += '<div class="err">Token CSRF invalido. Intenta mas tarde.</div>';
						break;
					case 10:
						document.getElementById('errs').innerHTML += '<div class="err">No me pude conectar con el servidor.</div>';
						break;
					default:
						document.getElementById('errs').innerHTML += '<div class="err">Error desconocido. Intenta mas tarde.</div>';
				}
			}
		}
		catch(e) {
			document.getElementById('errs').innerHTML = '<div class="err">El servidor se encuentra APAGADO!</div>';
		}
		setTimeout(function() {
			document.getElementById('errs').style.transition = transition;
			document.getElementById('errs').style.opacity = 1;
		}, 10);
	});
}
