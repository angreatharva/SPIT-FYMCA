function logShoeDetails(element) {
  const name = element.getAttribute("data-name");
  const description = element.getAttribute("data-description");
  const price = element.getAttribute("data-price");

  console.log(`Name: ${name}`);
  console.log(`Description: ${description}`);
  console.log(`Price: ${price}`);
}
