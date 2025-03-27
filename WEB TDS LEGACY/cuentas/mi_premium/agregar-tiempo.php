<?php                   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    require_logged();
  
?><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/caja.css" rel="stylesheet" type="text/css">
    <link href="/panel-premium.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <link href="/encuestas.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/cuentas/encuestas/encuestas.js"></script>
    <script type="text/javascript" src="/comun/js/jquery-min.js"></script>
    <style type="text/css">
    .subpen li {
        height: 16px;
        padding-bottom: 2px;
    }

    .anuevo {
        color: #0f5;
    }
    </style>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel="stylesheet" type="text/css">
</head>

<body id="seccion_premium" onload="init();">
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;">
                    <span style="display: inline-block; height: 100%; vertical-align: middle;"></span>
                    <img src="/header_images/_preloader.gif" style="vertical-align: middle; max-height: 100%">
                </div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class="titulo_seccion">
                <h1>Agregar tiempo premium</h1>
            </div>
            <div id="main">
                <div id="panel-premium">
                    <div class="cuentas_premium" style="text-align:left;">
                        <div class="tit">
                            <h1>Panel de <?php echo $_SESSION['username'] ?></h1>
                            <?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
                        </div>
                        <div id="centro_panel">
                            <div class="izq" style="width: 500px; ">
                                <ul class="beneficios">
                                <li><b>Información de cuenta:</b>
                                 
                            <br>Saldo actual: $ <?php 
                            echo get_tdspesos();?></li>

                               

                                <li class="monedas">
                                        <b><a>¡Cargar tiempo premium!</a></b><br>
                                        <ul class="beneficios subpen">
                                                                                
<style>
          
          .container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

header {
    text-align: center;
    margin-bottom: 20px;
}

.products {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.product {
    width: 48%;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    padding: 10px;
    box-sizing: border-box;
}

.product img {
    max-width: 100%;
    height: auto;
}

.product-info h3 {
    margin-top: 0;
}

.price {
    margin-bottom: 5px;
}

.add-to-cart {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 8px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-top: 10px;
    cursor: pointer;
}

.add-to-cart:hover {
    background-color: #45a049;
}

/* Estilos del carrito */
#products-id {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    background-color: #f4f4f4;
    width: 300px;
    padding: 20px;
    box-sizing: border-box;
    display: none;
    overflow-y: auto;
}

#products-id header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

#products-id header h2 {
    margin: 0;
}

#products-id header button {
    background-color: #f44336;
    border: none;
    color: white;
    padding: 8px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
}

#products-id header button:hover {
    background-color: #d32f2f;
}

.card-items {
    margin-bottom: 20px;
}

.price-total {
    margin-bottom: 10px;
}

.count-product {
    margin-bottom: 20px;
}
.cuentas_premium .izq p {
    min-height: 75px;
}
.buy-button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 8px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
}

.buy-button:hover {
    background-color: #45a049;
}
          
</style>

    <section class="container">
        <div class="products">
            
        </div>
         
    </section>
    
    <script>


    function loadProducts() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'cuentas/agregartiempo_backend.php', true);
        xhr.onload = function() {

            if (xhr.status === 200) {
                
                productos = JSON.parse(xhr.responseText);
                productos.forEach(producto => {
                    displayProduct(producto);                
                });
                
            }
        };
        xhr.send();
    }

    function displayProduct(producto) {
        const productsContainer = document.querySelector('.products');
        const div = document.createElement('div');
        div.classList.add('product');
        
        if (producto.imagen) {
            div.innerHTML = `
                <img src="imagenes/${producto.imagen}.png" alt="${producto.nombre}">
                <div class="product-info">
                    <h3>${producto.nombre}</h3>
                    <p class="description">${producto.descripcion}</p>
                    <button class="add-to-cart" data-id="${producto.id}">Comprar por $${producto.precio}</button>
                </div>
            `;
        } else {
            div.innerHTML = `
                <div class="product-info">
                    <h3>${producto.nombre}</h3>
                    <p class="description">${producto.descripcion}</p>
                    <button class="add-to-cart" data-id="${producto.id}">Comprar por $${producto.precio}</button>
                </div>
            `;
        }
        productsContainer.appendChild(div);
    }
    

</script>
                                                
                                    </li>                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        loadProducts();
                        
                        const productsContainer = document.querySelector('.products');

                        productsContainer.addEventListener('click', function(event) {
                            if (event.target.classList.contains('add-to-cart')) {
                                const productId = event.target.dataset.id;

                                console.log('Procesando compra del producto con ID:', productId);
                                
                                 fetch('cuentas/agregartiempo_backend.php', {
                                     method: 'POST',
                                     body: JSON.stringify({ productId: productId }),
                                     headers: {
                                         'Content-Type': 'application/json'
                                     }
                                 })
                                 .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Hubo un problema al procesar la compra');
                                    }
                                    return response.json();
                                 })
                                 .then(data => {
                                    if (data.error) {
                                        throw new Error(data.error);
                                    } else if (data.message) {
                                        // Si la respuesta contiene un mensaje de éxito
                                        console.log('Response:', data);
                                        alert(data.message);
                                        window.location.href = 'cpremium.php?a=tienda';
                                    } else {
                                        // Si la respuesta no contiene ni error ni mensaje de éxito
                                        throw new Error('Respuesta inesperada del servidor');
                                    }
                                })
                                 .catch(error => {
                                     alert(error);
                                 });

                            }
                        });
                        
                    });
                </script>
                