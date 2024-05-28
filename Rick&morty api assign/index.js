fetch("https://rickandmortyapi.com/api/character/306")
		.then(response => response.json())
		.then(data => {
			document.getElementById("character-name").textContent = data.name;
			document.getElementById("character-status").textContent = data.status;
			document.getElementById("character-species").textContent = data.species;
			document.getElementById("character-gender").textContent = data.gender;
			document.getElementById("character-origin").textContent = data.origin.name;
			document.getElementById("character-location").textContent = data.location.name;
			document.getElementById("character-episodes").textContent = data.episode.length;
			document.getElementById("character-image").src = data.image;
			document.getElementById("character-image").alt = data.name;
		})