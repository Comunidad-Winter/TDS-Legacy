let allContainerCart = document.querySelector('.products');
let containerBuyCart = document.querySelector('.card-items');
let priceTotal = document.querySelector('.price-total')
let amountProduct = document.querySelector('.count-product');
let buyThings = [];
let totalCard = 0;
let countProduct = 0;
loadEventListenrs();
function loadEventListenrs(){
    allContainerCart.addEventListener('click', addProduct);

    containerBuyCart.addEventListener('click', deleteProduct);
}

function addProduct(e){
    e.preventDefault();
    if (e.target.classList.contains('btn-add-cart')) {
        const selectProduct = e.target.parentElement; 
        readTheContent(selectProduct);
    }
}

function deleteProduct(e) {
    if (e.target.classList.contains('delete-product')) {
        const deleteId = e.target.getAttribute('data-id');

        // Buscar y eliminar el ID del producto del array buyThings
        buyThings = buyThings.filter(id => id !== deleteId);
        
        countProduct--;
    }
    
    if (buyThings.length === 0) {
        priceTotal.innerHTML = 0;
        amountProduct.innerHTML = 0;
    }
    loadHtml();
}

function readTheContent(product){
    // Obtener el ID numérico del producto
    const id = product.querySelector('a').getAttribute('data-id');
    
    addToCart(id);
}

function addToCart(id) {
    // Verificar si el ID ya está en el carrito
    const exist = buyThings.includes(id);

    if (exist) {
        // Si el ID ya está en el carrito, no hacemos nada
        return;
    } else {
        // Si el ID no está en el carrito, lo agregamos
        buyThings.push(id);
        countProduct++;
    }

    loadHtml();
}

function loadHtml(){
    clearHtml();
    
    buyThings.forEach(id => {
        
        const row = document.createElement('div');
        row.classList.add('item');
        row.innerHTML = `
             
            <div class="item-content">
                <h5>Nombre del producto</h5>
                <h5 class="cart-price">Precio del producto$</h5>
                <h6>Amount: 1</h6>
            </div>
            <span class="delete-product" data-id="${id}">X</span>
        `;
        containerBuyCart.appendChild(row);
    });

    // Actualizar el total y la cantidad de productos en el carrito
    priceTotal.innerHTML = totalCard;
    amountProduct.innerHTML = countProduct;
}

function clearHtml(){
    containerBuyCart.innerHTML = '';
}
