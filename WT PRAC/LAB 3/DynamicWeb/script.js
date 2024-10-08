function logShoeDetails(element) {
  const name = element.getAttribute("data-name");
  const image = element.getAttribute("data-image");
  const description = element.getAttribute("data-description");
  const price = element.getAttribute("data-price");

  console.log(`Name: ${name}`);
  console.log(`Image: ${image}`);
  console.log(`Description: ${description}`);
  console.log(`Price: ${price}`);

  // Store the product details in localStorage or sessionStorage
  localStorage.setItem("productName", name);
  localStorage.setItem("productImage", image);
  localStorage.setItem("productDescription", description);
  localStorage.setItem("productPrice", price);

  // Navigate to the product details page
  window.location.href = "productsDetail.html";
}
