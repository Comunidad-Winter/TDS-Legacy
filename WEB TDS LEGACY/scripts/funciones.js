function nuevoAjax()
{var xmlhttp=false;try
{xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");}
catch(e)
{try
{xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}
catch(E){xmlhttp=false;}}
if(!xmlhttp&&typeof XMLHttpRequest!='undefined'){xmlhttp=new XMLHttpRequest();}
return xmlhttp;}
function cargarComent(donde,id){var ajax2=nuevoAjax();ajax2.open("GET","comentarios/control.php?id="+parseInt(id),true);ajax2.onreadystatechange=function(){if(ajax2.readyState==4){document.getElementById(donde).innerHTML=ajax2.responseText;}}
ajax2.send(null);}
function miniest(nombre){if(nombre.value.length==0){alert('Ingrese el nick del personaje');nombre.focus();return false;}
var checkOK="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"+"abcdefghijklmnñopqrstuvwxyz ";var checkStr=nombre.value;var allValid=true;for(i=0;i<checkStr.length;i++){ch=checkStr.charAt(i);for(j=0;j<checkOK.length;j++)
if(ch==checkOK.charAt(j))
break;if(j==checkOK.length){allValid=false;break;}}
if(!allValid){alert("El personaje no existe.");nombre.focus();return(false);}}
function recu(formulario){if(formulario.nick.value.length<1){alert("Por favor ingrese un \"Nick\".");formulario.nick.focus();return(false);}
var checkOK="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"+"abcdefghijklmnñopqrstuvwxyz ";var checkStr=formulario.nick.value;var allValid=true;for(i=0;i<checkStr.length;i++){ch=checkStr.charAt(i);for(j=0;j<checkOK.length;j++)
if(ch==checkOK.charAt(j))
break;if(j==checkOK.length){allValid=false;break;}}
if(!allValid){alert("El personaje no existe.");formulario.nick.focus();return(false);}
if((formulario.mail.value.indexOf('@',0)==-1)||(formulario.mail.value.indexOf('.',0)==-1)){alert("Escriba una dirección de correo válida en el campo \"Email\".");formulario.mail.focus()
return(false);}
return(true);}
function borrar(campo){campo.value='';}
function verimagen_noticias(url){var theTop=30;var imagen=document.getElementById('imagengrande');imagen.innerHTML='<img src="'+url+'"  title="Click aquí para cerrar la imagen" border="1"/>';imagen.style.display='block';if(window.innerHeight){pos=window.pageYOffset}else if(document.documentElement&&document.documentElement.scrollTop){pos=document.documentElement.scrollTop}else if(document.body){pos=document.body.scrollTop}
if(pos<theTop)
pos=theTop;else
pos+=30;imagen.style.top=pos+'px';return false;}
function ocultar(){document.getElementById('imagengrande').style.display="none";}