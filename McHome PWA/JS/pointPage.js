// Link elements
friesLink = document.getElementById("friesLink");
burgerLink = document.getElementById("burgerLink");
iceCreamLink = document.getElementById("iceCreamLink");

// Pin container
pinContainer = document.querySelector(".container-pop");

// Buttons ("yes", "no", "close")
noButton = document.getElementById("no");
yesButton = document.getElementById("yes");
closeButton = document.getElementById("close");

// Insert pins here 
pinFries = document.getElementById("frenchFriesPin");
pinBurger = document.getElementById("burgerPin");
pinIceCream = document.getElementById("iceCreamPin");


// QR code 
qrCodePop = document.querySelector(".qr-pop");

// Using links to display the container and the corresponding images. Take away the display for other images.
friesLink.addEventListener("click", function(e) {
    e.preventDefault();
    pinContainer.style.display = "block";
    pinFries.style.display = "block";
    pinBurger.style.display = "none";
    pinIceCream.style.display = "none";
});

burgerLink.addEventListener("click", function(e) {
    e.preventDefault();
    pinContainer.style.display = "block";
    pinBurger.style.display = "block";
    pinFries.style.display = "none";
    pinIceCream.style.display = "none";
});

iceCreamLink.addEventListener("click", function(e) {
    e.preventDefault();
    pinContainer.style.display = "block";
    pinIceCream.style.display = "block";
    pinFries.style.display = "none";
    pinBurger.style.display = "none";
});

// "No" takes away the container (do not change)
noButton.addEventListener("click", function() {
    pinContainer.style.display = "none";
});

// "Yes" continues the flow from one of the pins and keeps the images, displaying the QR code, and brings in the close button (do not change)
yesButton.addEventListener("click", function() {
    qrCodePop.style.display = "block";
    yesButton.style.display = "none";
    noButton.style.display = "none";
    closeButton.style.display = "block";
});

// Reset functionality (do not change)
closeButton.addEventListener("click", function() {
    qrCodePop.style.display = "none";
    yesButton.style.display = "block";
    noButton.style.display = "block";
    closeButton.style.display = "none";
    pinContainer.style.display = "none";
});
