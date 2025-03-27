var ajax=null;
var path="cuentas/mercado/";
var antsec="";
var antparam="";
var antpage="";
var cambiopagina=false;
var aux;
function volverDeEst() {

		if (cambiopagina==true && antpage != "") {
			seccion(5);
		} else if (antsec==5) {
			seccion(5);
		} else if (antsec==14) {
			comprar(antparam);
		} else {
			window.location="/cpremium.php?a=mercado";
		}
}

function chequearnumero(cadena) {
var i;
if (cadena < 1 || cadena > 2000000000) {
return (false);
 }
	
var checkOK = "1234567890";
var checkStr = cadena;
var allValid = true; 
  
for (i = 0; i < checkStr.length; i++) {
	ch = checkStr.charAt(i); 
	for (j = 0; j < checkOK.length; j++) {
		if (ch == checkOK.charAt(j)) {
		break; 
		} else {
		if (checkOK.charAt(j) == "0") {
			allValid = false;
			break;
		}
		}
	}
}
		
if (!allValid) { 
    return (false); 
} 	
return true;
}


function dameseccion(numero) {
	switch (numero) {
		case 17:
			return path+"ventapj3.php";
			break;
		case 16:
			return (path+"comprar2.php");
			break;
		case 15:
			return (path+"est.php");
			break;
		case 14:
			return (path+"comprar.php");
			break;
		case 13:
			return (path+"sacar.php");
			break;
		case 7:
			//return (path+"menu_principal.php");
			window.location="/cpremium.php?a=mercado";
			break;
		case 6:
			return (path+"sacarfrm.php");
			break;
		case 5:
			aux = antpage;
			antsec=5;
			antparam="";
			cambiopagina=false;
			antpage="";
			return (path+"listaventas.php");
			break;
		case 4:
			return (path+"ventapj.php");
			break;
		case 3:
			return (path+"ventapj2.php");
			break;
		case 2: 
			return (path+"ventapj3.php");
			break;
		case 1:
			return (path+"ayuda.htm");
			break;
		//////////////////////////
		default:	
			return (path+"ventas.htm");
			break;
		}
}


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

function venderpj(paso) {
	var tabla= document.getElementById('contenido');
	
	if (paso==1) {
		var pin=document.form1.pin.value;
		
		if (pin.length < 1) {
    		alert("Ingrese un PIN válido.");
    		return (false);
  		}
  
  		
		tabla.innerHTML = "Cargando";

		ajax.open("POST", path+"ventapj2.php");
	
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
		ajax.send("pin="+encodeURIComponent(pin));
	
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
		}
	} else {
		
		var confirmacion=document.form1.confirmacion.value;
		
		// Obtengo los personajes a vender
		var listaPjs=document.getElementById('aVender');
				
		if (confirmacion.length != 6) {
   			alert("Por favor ingrese el codigo de confirmación que se le envio a su correo electronico.");
    		document.form1.confirmacion.focus();
    		return (false);
  		}
		
		if (listaPjs.length == 0) { 
			alert("Por favor, elegi que personajes queres poner a la venta. Hace doble click en el nombre del personaje que deseas vender o seleccionalo y pulsa en el botón agregar");
			return false;
		}
		
		aVender = "";
		
		for (var i = 0; i < listaPjs.length; i++) {
				if (i != 0) aVender+= "-";
					aVender =aVender + listaPjs.options[i].value;
		}
		
		var modo=document.form1.rb;
		var monedas=document.form1.monedas.value;
		var pedido=document.form1.pedido.value;
		
		if (modo[0].checked) { //VENDE POR ORO
			rb=1;
			if (chequearnumero(monedas)==false) {
			alert("Por favor ingrese una cantidad de oro válida. Rango de precios válido entre 1 y 2.000.000.000 de monedas de oro.")
			return false;
			}
		} else if (modo[1].checked) {
			rb=2;
			 
		}
		
		
		var tcoment=document.form1.tcoment.value;

		var passpriv=document.form1.passpriv.value;
		var permitirComentarios=document.form1.permitirComentarios.value;		
		var mc=document.form1.mc.checked ;
		
		if (mc==true) {
			mc=1;
		} else {
			mc=0;
		}
			
		tabla.innerHTML = "Cargando";

		ajax.open("POST", path + "ventapj3.php");
	
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
		if (rb == 1 || rb == 2) {
			ajax.send("confirmacion="+confirmacion+"&pjs="+aVender+"&mc="+mc+"&passpriv="+passpriv+"&pedido="+pedido+"&tcoment="+tcoment+"&rb="+rb+"&monedas="+monedas+"&permitirComentarios="+permitirComentarios);
		} else if (rb == 3) {
			ajax.send("confirmacion="+confirmacion+"&pjs="+aVender+"&mc="+mc+"&passpriv="+passpriv+"&tcoment="+tcoment+"&rb="+rb+"&precioInicial="+precioInicial+"&subaMinima="+subaMinima+"&fechaFin="+fechaFin+"&avisarme="+avisarme+"&permitirComentarios="+permitirComentarios);
		} else {
			alert("Elegí un modo de publicacion");
			return;
		}
		
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
		}
	}
}
function seccion(numero){
	var tabla;
	var tt;
	 
	 tabla= document.getElementById('contenido');
	tabla.innerHTML = "Cargando";
	
	ajax=nuevoAjax();
	ajax.open("GET", dameseccion(numero));
	ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
	}
	ajax.send(null)
	return false;
}

function seccionespecial(numero) {
	var tabla;
	var tt;
	 
	tabla= document.getElementById('contenido');
	tabla.innerHTML = "Cargando";
	
	ajax=nuevoAjax();
	ajax.open("GET", dameseccion(numero)+"?del=1");
	ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
	}
	ajax.send(null)
	return false;
}

function comprar(pj) {
	antsec=14;
	antparam=pj;
	tabla= document.getElementById('contenido');
	tabla.innerHTML = "Cargando";
	ajax=nuevoAjax();
	
	ajax.open("GET", path + "comprar.php?pj="+pj);
	ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
	}
	ajax.send(null);
	return false;
}

function verest(pj) {
	tabla= document.getElementById('contenido');
	tabla.innerHTML = "Cargando";
	ajax=nuevoAjax();
	ajax.open("GET", path + "est.php?nick="+pj);
	ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
	}
	ajax.send(null);
	return false;
}


function comprar2(pj) {

		tabla= document.getElementById('contenido');
		var pass=document.form2.pass.value;

		
		var passpriv
		try {
				passpriv=document.form2.passpriv.value;
				if (passpriv.length == 0) {
					alert ('Ingese el password privado');
					document.form2.passpriv.focus();
					return false;
				}
		} catch(E) {
			   passpriv="";
		}
		
		
			var pjsOfrecidos = document.getElementById('aVender') ;
			var pjSelect =  document.getElementById('pjSelect');
			var oferta =  document.getElementById('oferta');
					
			
			var i;
			var aCambiar="";
			var modo;
			
			if (pjsOfrecidos != null) { // Intercambio de personajes 
			
				modo=2;
				
				for (i = 0; i < pjsOfrecidos.length; i++) {
					if (i != 0) aCambiar+= "-";
					aCambiar =aCambiar + pjsOfrecidos.options[i].value;
				}
				
				if (i==0) { // No puso ningun personaje para intercambiar
					alert("Debes agregar, al menos, un personaje para intercambiar. Selecciona el personaje que deseas intercambiar en la lista y presiona 'Agregar'");
					return false;
				}
				
				var comentario=document.form2.comentario.value;
		
				if (comentario.indexOf ('http://', 0) != -1 || comentario.indexOf ('www', 0) != -1 || comentario.indexOf ('.com', 0) != -1  || comentario.indexOf ('.php', 0) != -1) {
					alert ('No se pueden poner links en el comentario');
					return false;
				}
			
			} else if (pjSelect != null && oferta!=null) { // Subasta
				
				modo = 3;
				
				if (pjSelect.selectedIndex != -1) {
					aCambiar=pjSelect.options[pjSelect.selectedIndex].value;					
				} else {
					alert("Debes seleccionar el personaje con el cual vas a pagar la compra.");
					return false;
				}
				
				if (chequearnumero(oferta.value) == false) {
					alert("Por favor ingrese una cantidad de oro válida para la oferta. Rango válido entre 1 y 2.000.000.000 de monedas de oro.");
					return false;	
				}			
				
			} else if (pjSelect!= null) { // Compra por oro
			
				modo = 1;
				
				if (pjSelect.selectedIndex != -1) {
					aCambiar=pjSelect.options[pjSelect.selectedIndex].value;					
				} else {
					alert("Debes seleccionar el personaje con el cual vas a pagar la compra.");
					return false;
				}
			} else {
				return false;	
			}

		tabla.innerHTML = "Cargando";
		ajax=nuevoAjax();	
		
	
		ajax.open("POST", path + "comprar2.php");
	
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	
		if (modo == 1 || modo == 2) {
			ajax.send("pass="+pass+"&aCambiar="+aCambiar+"&pjc="+pj+"&comentario="+comentario+"&passpriv="+passpriv);
		} else if ( modo == 3) {
			ajax.send("pass="+pass+"&aCambiar="+aCambiar+"&pjc="+pj+"&oferta="+oferta.value+"&passpriv="+passpriv);
		} else {
			alert("Se ha producido un error. Intente más tarde.");
			return false;
		}
		
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
		}
	
	return false;
}

function filtrar(chequear) {

    if (chequear == 1) {	
    	var tipo = document.getElementById("condicion").value;
		var nivel = document.getElementById("nivel").value;
        
        if (nivel != "--" && tipo == "Todas") {
            return true;
        }
        
         if (nivel == "--" && tipo != "Todas") {
            return true;
        }
    }
    
	buscarmao();
    
    return true;
}

/* Funciones para agregar / quitar personajes de la lista
de personajes a publicar */
function pasar() {
	var obj=document.getElementById('misPjs');
	var obj2=document.getElementById('aVender');
	var txt=obj.options[obj.selectedIndex].text;
	var valor=obj.options[obj.selectedIndex].value;
	var nivel = 0;
    
	if (obj.selectedIndex==-1) return;

	if (obj2.options.length > 4) {
		alert('No puedes ofrecer más de 4 personajes!');
		return false;
	}
	obj.options[obj.selectedIndex]=null;
	opc = new Option(txt,valor);
	obj2.options[obj2.options.length]=opc;	
    
    actualizarImpuesto();
		
	
}

function actualizarImpuesto() {

	var obj2=document.getElementById('aVender');
	var txt=obj2.options[0].text;
    var modo=document.form1.rb;
    var infoPrecio=document.getElementById('precio_publicacicon');
    
    if (modo[1].checked) {
        if (infoPrecio!=undefined) {            
            infoPrecio.innerHTML = "<strong>INFO: </strong> No tienes que pagar impuestos ya que sos premium.";            
            infoPrecio.style.display='';
			infoPrecio.style.color='#29da30';
        } 
    } else {
    	infoPrecio.style.display='none';
   	}
    
}

function quitar() {
	var obj=document.getElementById('aVender');
	if (obj.selectedIndex==-1) return;
	
	var txt=obj.options[obj.selectedIndex].text;
	var valor=obj.options[obj.selectedIndex].value;
	obj.options[obj.selectedIndex]=null;
	
    var infoPrecio=document.getElementById('precio_publicacicon');
    
    if (infoPrecio!=undefined) {
        infoPrecio.style.display='none';
    }
    
    var obj2=document.getElementById('misPjs');
    opc = new Option(txt,valor);
    obj2.options[obj2.options.length]=opc;	
}

function paginamao(numero) {
		var tabla;
		cambiopagina=true;
		antpage=numero;
		tabla= document.getElementById('listamercado');
		tabla.innerHTML = '<img src="/cargando.gif" />';
		ajax.open("POST", "/cuentas/mercado/listamao.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("mostrar="+numero);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					tabla.innerHTML = ajax.responseText;
				}
		}
}
function buscarmao() {
		var tabla;
		tabla= document.getElementById('listamercado');
		tabla.innerHTML = '<img src="/cargando.gif" />';
        
		var buscar=document.form2.searchmao.value;
        var clase = document.getElementById("clase").value.toUpperCase();
		var tipo = document.getElementById("tipo").value;
		var nivel = document.getElementById("nivel").value;
		var condi = document.getElementById("condicion").value;
        
		ajax.open("POST", "/cuentas/mercado/listamao.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("mostrar=1&buscar="+buscar+"&clase="+clase+"&tipo="+tipo+"&nivel="+nivel+"&condi="+condi);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					tabla.innerHTML = ajax.responseText;
                    return true;
				}
		}
        
        return true;
}

function quitarVenta(pj,id) {
		var boton;
		
		boton= document.getElementById('boton'+id);
		boton.innerHTML = "Quitando"
		ajax.open("POST", "/cuentas/mercado/AjaxConectorAdminVentas.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("id_publicacion="+pj);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = parseInt (ajax.responseText);

					if (respuesta  == 0) {
						boton.innerHTML = "Quitado";	
					} else {
						boton.innerHTML = "Error:" + ajax.responseText;
					}
				}
		}
}


function finalizarSubasta(idSubasta,id) {
		var boton;
		
		boton= document.getElementById('sub'+id);
		boton.innerHTML = "Finalizando"
		ajax.open("POST", "/cuentas/mercado/finalizarSubasta.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("idsubasta="+idSubasta);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = parseInt (ajax.responseText);
					if (respuesta  == 0) {
						boton.innerHTML = "Finalizado";	
					} else {
						boton.innerHTML = "Error";
					}
				}
		}
		
		return false;
}


function cancelarVenta(codigo, idBoton) {

		var boton;
		
		boton= document.getElementById('inter'+idBoton);
		boton.innerHTML = "Cancelando";
        
		ajax.open("POST", "/cuentas/mercado/AjaxConectorAdminVentas2.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("id_confirmacion="+codigo);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = parseInt (ajax.responseText);
					if (respuesta  == 0) {
						boton.innerHTML = "Cancelado";	
					} else {
						boton.innerHTML = "Error:" + ajax.responseText;
					}
				}
		}
}

function cancelarOfrecimiento(codigo, idBoton) {

		var boton;
		
		boton= document.getElementById('ofre'+idBoton);
		boton.innerHTML = "Cancelando";
        
		ajax.open("POST", "/cuentas/mercado/AjaxConectorAdminVentas3.php");
		ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		ajax.send("id="+codigo);
		ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = parseInt (ajax.responseText);
					if (respuesta  == 0) {
						boton.innerHTML = "Cancelado";	
					} else {
						boton.innerHTML = "Error:" + ajax.responseText;
					}
				}
		}
}

//VENTA TOGGLE VISIBLE
function cambiar(id) {
	var intercambio = document.getElementById("ccambio");
	var oro = document.getElementById("cmoneda");
	var sub = document.getElementById("subastaform");
	if (id == '1' ) {
		intercambio.style.display = 'none';
		oro.style.display = '';
		sub.style.display = 'none';
	} else if (id == '2' ) {
		intercambio.style.display = '';
		oro.style.display = 'none';
		sub.style.display = 'none';
	} else {
		intercambio.style.display = 'none';
		oro.style.display = 'none';
		sub.style.display = '';
	}
    
    	actualizarImpuesto();
		
}