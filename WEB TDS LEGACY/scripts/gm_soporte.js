		let paginaActual = 1
		let paginaActual2 = 1
		getData(paginaActual,paginaActual2)

		document.getElementById("campo").addEventListener("keyup", function() {
		    getData(1,paginaActual2 )
		}, false)

		document.getElementById("campo2").addEventListener("keyup", function() {
		    getData(paginaActual, 1)
		}, false)

		function getData(pagina,pagina2) {
		    let input = document.getElementById("campo").value
		    let estado = document.getElementById("estado").value
		    let sector = document.getElementById("sector").value

		    let content = document.getElementById("content")


			let input2 = document.getElementById("campo2").value
		    let estado2 = document.getElementById("estado2").value
		    let sector2 = document.getElementById("sector2").value

		    let content2 = document.getElementById("content2")

		    if (pagina != null) {
		        paginaActual = pagina
		    }

		    if (pagina2 != null) {
		        paginaActual2 = pagina2
		    }
		    let url = "cuentas/soportes/get_soportes.php"
		    let formaData = new FormData()
		    formaData.append('campo', input)
		    formaData.append('pagina', paginaActual)
		    formaData.append('estado', estado)
		    formaData.append('sector', sector)
			

			formaData.append('campo2', input2)
		    formaData.append('pagina2', paginaActual2)
		    formaData.append('estado2', estado2)
		    formaData.append('sector2', sector2)


		    fetch(url, {
		            method: "POST",
		            body: formaData
		        }).then(response => response.json())
		        .then(data => {
		            content.innerHTML = data.data
		            content2.innerHTML = data.data2

		            document.getElementById("lbl-total").innerHTML = 'Mostrando ' + data.totalFiltro +
		                ' de ' + data.totalRegistros + ' registros'
		            document.getElementById("nav-paginacion").innerHTML = data.paginacion

					document.getElementById("lbl-total2").innerHTML = 'Mostrando ' + data.totalFiltro2 +
		                ' de ' + data.totalRegistros2 + ' registros'
		            document.getElementById("nav-paginacion2").innerHTML = data.paginacion2


		        }).catch(err => console.log(err))
		} 