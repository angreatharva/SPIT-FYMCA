<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
</head>
<body>
    <h1 id="productName"></h1>
    <img id="productImage" src="" alt="Product Image">
    <p id="productDescription"></p>
    <p id="productPrice"></p>

    <script>
    // Fetch product details based on product ID
    async function fetchProductDetails() {
        const productId = localStorage.getItem("productId");
        if (!productId) {
            console.error("Product ID not found.");
            return;
        }
        console.log(`ProductId getItem: ${productId}`);
        const response = await fetch(`server.php?fetch_product_details&id=${productId}`);
        const product = await response.json();
        

        // Log the entire product object
        console.log(product); 

        // Access the product properties with the correct case
        console.log(`ProductId: ${product.Id}`);
        console.log(`Name: ${product.name}`);
        console.log(`Image: ${product.img}`);
        console.log(`Description Small: ${product.smallDesc}`);
        console.log(`Description Long: ${product.longDesc}`);
        console.log(`Price: ${product.price}`);

        // Update the page with product details
        document.getElementById("productName").innerText = product.name;
        document.getElementById("productImage").src = product.img; // Adjust path if necessary
        document.getElementById("productDescription").innerText = product.longDesc;
        document.getElementById("productPrice").innerText = `MRP: ₹ ${product.price}`;
    }

    // Call on page load
    window.onload = fetchProductDetails;
</script>


</body>
</html>
