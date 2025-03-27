
   // Java Document
   var nombreNivel =  new Array("","Baja","Media","Alta");
   
     
   function isCadenaValido(cadena){var checkOK="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"+"abcdefghijklmnñopqrstuvwxyz "+"0123456789"+".-_";var checkStr=cadena;var allValid=true;for(i=0;i<checkStr.length;i++){ch=checkStr.charAt(i);for(j=0;j<checkOK.length;j++)
   if(ch==checkOK.charAt(j))break;if(j==checkOK.length){allValid=false;break;}}
   return allValid;}
   function isNombreCuentaValido(nombre){if(nombre.length==0||nombre.length<4||nombre.length>30){return false;}
   if(isCadenaValido(nombre)){return true;}else{return false;}}
   function isMailValido(mail){if((mail.indexOf('@',0)==-1)||(mail.indexOf('.',0)==-1)){return false;}
   return true;}
   function isNombreValido(nombre){if(nombre.length==0||nombre.length<3||nombre.length>30){return false;}else{return true;}}
   function isPassValido(pass){if(pass.length<4||pass.length>30){return false;}else{return true;}}
   function isPINValido(pin){if(pin.length<4||pin.length>20){return false;}else{return true;}}
   function poderClave(nombre){if(nombre.length<8){return 0;}
   var mayusculas="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";var minusculas="abcdefghijklmnñopqrstuvwxyz ";var numeros="0123456789";var nivel=0;var checkStr=nombre;var subio=false;for(i=0;i<checkStr.length;i++){ch=checkStr.charAt(i);for(j=0;j<mayusculas.length;j++){if(ch==mayusculas.charAt(j)){nivel++;subio=true;}}
   if(subio)break;}
   subio=false;for(i=0;i<checkStr.length;i++){ch=checkStr.charAt(i);for(j=0;j<minusculas.length;j++){if(ch==minusculas.charAt(j)){nivel++;subio=true;}}
   if(subio)break;}
   subio=false;for(i=0;i<checkStr.length;i++){ch=checkStr.charAt(i);for(j=0;j<numeros.length;j++){if(ch==numeros.charAt(j)){nivel++;subio=true;}}
   if(subio)break;}
   return nivel;}
   function isGenericoValido(campo){if(campo.length==0||campo.length<3||campo.length>30||isCadenaValido(campo)!=true){return false;}else{return true;}}
   function isNombreApellidoValido(campo){if(campo.length==0||campo.length<3||campo.length>60||isCadenaValido(campo)!=true){return false;}else{return true;}}
   
   function mostrarPoderClave(nombre) {
   
   	var barra = document.getElementById('barra');
   	var txtBarra = document.getElementById('txt_barra');
   	var poder =  poderClave(nombre.value);
   
   	txtBarra.innerHTML =  nombreNivel[poder];
   	barra.style.width = 77 * poder + "px";
   		
   	return false;
   }
   
   function chequearReIngreso() {
   	var pass = document.getElementById('password').value;
   	
   	if (pass != '') {
   		var campo = document.getElementById('password2');
   		var resultado = document.getElementById('errpassword2');
   	
   		if (campo.value == "") {
   			document.getElementById('errorpassword2').innerHTML = "Por favor, re-ingresa la contraseña."; 
   			resultado.className = "err";
   			return false;
   		} else if (pass != campo.value) {
   			document.getElementById('errorpassword2').innerHTML = "Las contraseñas no coinciden."; 
   			resultado.className = "err";
   			return false;
   		} else {
   			resultado.className = "noerr";
   			return true;
   		}
   	}
   	return false;
   }
   
   	
   	
   function validarFormulario() {
   	var hayError = false;
   
   	var campo = document.getElementById('cActual');
   	var resultado = document.getElementById('errPasswordActual');
   	
   	if (isPassValido(campo.value)==false) {
   		resultado.className = "err";
   		hayError = true;
   	} else {
   		resultado.className = "noerr";
   	}
   
   	
   	var campo = document.getElementById('Password');
   	var resultado = document.getElementById('errPassworNuevo');
   	
   	if (isPassValido(campo.value)==false) {
   		resultado.className = "err";
   		hayError = true;
   	} else {
   		resultado.className = "noerr";
   		
   		if (chequearReIngreso()==false) {
   			hayError = true;
   		}
   	}
   	
   	var campo = document.getElementById('pin');
   	var resultado = document.getElementById('errPIN');
   	
   	if (isPINValido(campo.value)) {
   		resultado.className = "noerr";
   	} else {
   		resultado.className = "err";
   		hayError = true;
   	}
   		
   	return !hayError;
   }

   