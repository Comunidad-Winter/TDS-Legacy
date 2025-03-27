function verGms() {
	if (document.getElementById('servidores').selectedIndex==0) {
		document.getElementById('gmsTDS').style.display="";
		document.getElementById('gmsTDSF').style.display="none";
	} else {
		document.getElementById('gmsTDS').style.display="none";
		document.getElementById('gmsTDSF').style.display="";
	}
	
}

function validar() {

	if (document.ingresa.nombre.value == '') // verifico nombre
	{
		alert("Ingresa tu Nombre");
		document.ingresa.nombre.focus();
		return (false);
	}

	if ((document.ingresa.email.value.indexOf ('@', 0) == -1)||(document.ingresa.email.value.indexOf ('.', 0) == -1)) // verifico email
	{
		alert("Escribí una dirección de msn/email válida");
		document.ingresa.email.focus();
		return (false);
	}

	if (document.ingresa.qsabe.value == 'no_puso_nada') // verifico que sabe
		{
		alert("Que sabes?");
		document.ingresa.qsabe.focus();
		return (false);
	} else if (document.ingresa.qsabe.value == 'gm'){
		alert("ATENCION! Muchas gracias por querer formar parte del Staff como Game Master o Consejero. En estos momentos no nos encontramos en busqueda de Game Master o Consejeros. En la página de TDS Legacy Sur será publicado cuando sean abiertas las convocatorias para el ingreso de Game Masters o Consejeros. Muchas gracias.");
		return (false);
	}

	if (document.ingresa.programas.value == "") // verifico que experiencia
	{
		alert("Que programas utilizas para el "+ document.ingresa.qsabe.value +"?.");
		document.ingresa.qexp.focus();
		return (false);
	}
	
	if (document.ingresa.nombre.value == '') // verifico nombre
	{
		alert("Ingresa tu Nombre");
		document.ingresa.nombre.focus();
		return (false);
	}
	
	if (document.ingresa.comentarios.value == 'Contanos un poco mas de vos y de lo que sabes hacer') // verifico que experiencia
	{
		alert("Nos gustaria que nos cuentes mas de vos y de lo que sabes hacer");
		document.ingresa.comentarios.focus();
		return (false);
	}

	if (document.ingresa.captcha.value == '') // verifico que experiencia
	{
		alert("Por favor ingresa el resultado de la operación matemática");
		document.ingresa.captcha.focus();
		return (false);
	}
	return (true);
}

function quitartxt() // borro texto de comentarios
{
	if (document.ingresa.comentarios.value == 'Escribi lo que quieras agregar')
	{
		document.ingresa.comentarios.value = '';
	}
}
//-->