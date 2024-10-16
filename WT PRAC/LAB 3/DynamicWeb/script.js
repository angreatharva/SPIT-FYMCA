// Function to log product details and store them in localStorage
function logShoeDetails(element) {
  const productId = element.getAttribute("data-id");
  const name = element.getAttribute("data-name");
  const image = element.getAttribute("data-image");
  const description = element.getAttribute("data-description");
  const descriptionLong = element.getAttribute("data-description-long");
  const price = element.getAttribute("data-price");

  console.log(`Shoe Details`);
  console.log(`ProductId: ${productId}`);
  console.log(`Name: ${name}`);
  console.log(`Image: ${image}`);
  console.log(`Description Small: ${description}`);
  console.log(`Description Long: ${descriptionLong}`);
  console.log(`Price: ${price}`);

  // Store the product details in localStorage
  localStorage.setItem("productId", productId);
  localStorage.setItem("productName", name);
  localStorage.setItem("productImage", image);
  localStorage.setItem("productDescription", description);
  localStorage.setItem("productDescriptionLong", descriptionLong);
  localStorage.setItem("productPrice", price);

  // Navigate to the product details page
  window.location.href = "productsDetail.html";
}

// Function to load product details on the product details page
function loadProductDetails() {
  const name = localStorage.getItem("productName");
  const description = localStorage.getItem("productDescription");
  const price = localStorage.getItem("productPrice");
  const image = localStorage.getItem("productImage");

  // Check if all details are available in localStorage
  if (name && description && price && image) {
    document.getElementById("productName").textContent = name;
    document.getElementById("productDescription").textContent = description;
    document.getElementById("productPrice").textContent = price;

    // Ensure the product image element is correctly updated
    const productImageElement = document.getElementById("productImage");
    if (productImageElement) {
      productImageElement.src = image;
    } else {
      console.error("Product image element not found.");
    }
  } else {
    console.error("Product details missing in localStorage.");
  }
}

// Function to fetch products from the server
async function fetchProductsDB() {
  try {
    const response = await fetch('server.php?fetch_products');
    const products = await response.json();

    const productsContainer = document.getElementById('productsContainer');
    

    products.forEach(product => {
      const shoeContainer = document.createElement('div');
      shoeContainer.className = 'shoeContainer';
      shoeContainer.style.display = 'inline-block';
      shoeContainer.style.marginRight = '20px';
      shoeContainer.setAttribute('data-id', product.Id);
      shoeContainer.setAttribute('data-name', product.name);
      shoeContainer.setAttribute('data-image', product.img);
      shoeContainer.setAttribute('data-description', product.smallDesc);
      shoeContainer.setAttribute('data-description-long', product.longDesc);
      shoeContainer.setAttribute('data-price', `MRP : ₹ ${product.price}`);
      shoeContainer.onclick = () => logShoeDetails(shoeContainer);

      shoeContainer.innerHTML = `
        <div style="text-align: center; width: 100%">
          <img src="${product.img}" style="width: 280px" alt="${product.name}" />
          <h4>${product.name}</h4>
          <p>${product.smallDesc}</p>
          <p>MRP : ₹ ${product.price}</p>
        </div>
      `;

      productsContainer.appendChild(shoeContainer);
    });
  } catch (error) {
    console.error('Error fetching products:', error);
  }
}

// Function to select shoe size
let selectedSize = '';

function selectSize(element, size) {
  // Remove the selected class from all size elements
  const sizes = document.querySelectorAll('.shoeSize');
  sizes.forEach((sizeElement) => {
    sizeElement.classList.remove('selected');
  });

  // Add the selected class to the clicked element
  element.classList.add('selected');

  // Store the selected size
  selectedSize = size;
  console.log("Selected size:", selectedSize);
}

// Function to add the product to the bag
function addToBag() {
  if (!selectedSize) {
    alert("Please select a shoe size before adding to the bag.");
    return;
  }

  const productDetails = {
    name: localStorage.getItem("productName"),
    image: localStorage.getItem("productImage"),
    description: localStorage.getItem("productDescription"),
    price: localStorage.getItem("productPrice"),
    size: selectedSize
  };

  // Get the existing bag products from localStorage, or initialize an empty array
  let bagProducts = JSON.parse(localStorage.getItem("bagProducts")) || [];

  // // Check if the product with the same name and size already exists in the bag
  // const isDuplicate = bagProducts.some(product => 
  //   product.name === productDetails.name && product.size === productDetails.size
  // );

  // if (isDuplicate) {
  //   alert("This product with the selected size is already in your bag.");
  //   return;
  // }

  // Add the new product to the array
  bagProducts.push(productDetails);

  // Save the updated array back to localStorage
  localStorage.setItem("bagProducts", JSON.stringify(bagProducts));

  // Navigate to the bag page
  window.location.href = "bagPage.html";
}

// Function to load and display bag products
function loadBagProducts() {
  // Get the products stored in localStorage
  let bagProducts = JSON.parse(localStorage.getItem("bagProducts")) || [];

  const bagItemsContainer = document.getElementById("bagItemsContainer");
  const bagItemTemplate = document.getElementById("bagItemTemplate");

  // Clear the container before loading
  bagItemsContainer.innerHTML = "";

  if (bagProducts.length === 0) {
    bagItemsContainer.innerHTML = "<p>Your bag is empty.</p>";
    return;
  }

  // Iterate over each product and populate the template
  bagProducts.forEach((product, index) => {
    const productElement = bagItemTemplate.content.cloneNode(true);

    // Fill in the product details
    productElement.querySelector("img").src = product.image;
    productElement.querySelector("img").alt = product.name;
    productElement.querySelector(".productName").textContent = product.name;
    productElement.querySelector(".productDescription").textContent = product.description;
    productElement.querySelector(".productSize").textContent = `Size: ${product.size}`;
    productElement.querySelector(".productPrice").textContent = `${product.price}`;

    // Add an event listener to the remove button
    productElement.querySelector(".removeButton").addEventListener("click", () => {
      removeFromBag(index);
    });

    // Append the product element to the container
    bagItemsContainer.appendChild(productElement);
  });
}

// Function to remove a product from the bag
function removeFromBag(index) {
  let bagProducts = JSON.parse(localStorage.getItem("bagProducts")) || [];
  bagProducts.splice(index, 1); // Remove the product at the given index

  // Update the localStorage with the modified array
  localStorage.setItem("bagProducts", JSON.stringify(bagProducts));

  // Reload the page to update the displayed items
  loadBagProducts();
}

// Array to hold favorite products
let favorites = JSON.parse(localStorage.getItem("favorites")) || [];

// Function to add the product to favorites
function addToFavorites() {
  if (!selectedSize) {
    alert("Please select a shoe size before adding to favorites.");
    return;
  }

  const productDetails = {
    name: localStorage.getItem("productName"),
    image: localStorage.getItem("productImage"),
    description: localStorage.getItem("productDescription"),
    price: localStorage.getItem("productPrice"),
    size: selectedSize
  };

  // Get the existing favorites from localStorage, or initialize an empty array
  let favoriteProducts = JSON.parse(localStorage.getItem("favorites")) || [];

  // // Check if the product with the same name and size already exists in the favorites
  // const isDuplicate = favoriteProducts.some(product => 
  //   product.name === productDetails.name && product.size === productDetails.size
  // );

  // if (isDuplicate) {
  //   alert("This product with the selected size is already in your favorites.");
  //   return;
  // }

  // Add the new product to the array
  favoriteProducts.push(productDetails);

  // Save the updated array back to localStorage
  localStorage.setItem("favorites", JSON.stringify(favoriteProducts));

  alert("Product added to your favorites.");
}

// Function to load and display favorite products
function loadFavorites() {
  const favoriteList = JSON.parse(localStorage.getItem("favorites")) || [];
  const favoriteContainer = document.getElementById("favoritesContainer");
  const favoriteItemTemplate = document.getElementById("favoriteItemTemplate");

  favoriteContainer.innerHTML = ""; // Clear previous content

  if (favoriteList.length === 0) {
    favoriteContainer.innerHTML = "<p>Your favorite list is empty.</p>";
    return;
  }

  // Iterate over each product and populate the template
  favoriteList.forEach((product, index) => {
    const productElement = favoriteItemTemplate.content.cloneNode(true);

    // Populate the template with product details
    productElement.querySelector(".product-image").src = product.image;
    productElement.querySelector(".product-image").alt = product.name;
    productElement.querySelector(".product-name").textContent = product.name;
    productElement.querySelector(".product-description").textContent = product.description;
    productElement.querySelector(".product-size").textContent = `Size: ${product.size}`;
    productElement.querySelector(".product-price").textContent = `${product.price}`;

    // Add an event listener to the remove button
    productElement.querySelector(".remove-button").addEventListener("click", () => {
      removeFromFavorites(index);
    });

    // Append the product element to the container
    favoriteContainer.appendChild(productElement);
  });
}

// Function to remove a product from favorites
function removeFromFavorites(index) {
  const favoriteList = JSON.parse(localStorage.getItem("favorites")) || [];
  favoriteList.splice(index, 1); // Remove the product at the given index

  // Update the localStorage with the modified array
  localStorage.setItem("favorites", JSON.stringify(favoriteList));

  // Reload the page to update the displayed items
  loadFavorites();
}

// Call fetchProductsDB when the page loads
document.addEventListener("DOMContentLoaded", fetchProductsDB);
