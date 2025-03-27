function verimagen(url){var theTop=30;var imagen=document.getElementById('imagengrande');imagen.innerHTML='<img src="'+url+'"  title="Click aquí para cerrar la imagen" border="1"/>';imagen.style.display='block';if(window.innerHeight){pos=window.pageYOffset}else if(document.documentElement&&document.documentElement.scrollTop){pos=document.documentElement.scrollTop}else if(document.body){pos=document.body.scrollTop}
if(pos<theTop)
pos=theTop;else
pos+=30;imagen.style.top=pos+'px';return false;}
function ocultar(){document.getElementById('imagengrande').style.display="none";}