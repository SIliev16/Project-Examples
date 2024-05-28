// API 

// Author: Christiyan Borisov

// Description: This page is the fun facts generator API.

// Way of operation: It is split into 3 different sections. 1 section is based for the API, fetches it and extracts the info.
// 1 section is for the facts. It is functions that generate the facts, calculate, etc...
// And the other section is checking the url of the website in order to know whether is greek japanese french or american page.

//*****************************************************************************************************************************************************************************************

// Helper function to retrieve the current HTML file name
function getCurrentHTMLFileName() {
    var url = window.location.href;
    var parts = url.split("/");
    var fileName = parts[parts.length - 1];
    return fileName;
}

function checkWindowName() {
    var fileName = getCurrentHTMLFileName();
    var variable;

    if (fileName == "japanPage.html") {
        variable = 85;
    }
    if (fileName == "americanPage.html") {
        variable = 181;
    }
    if (fileName == "francePage.html") {
        variable = 57;
    }
    if (fileName == "greekPage.html") {
        variable = 67;
    }
    else {
        //troubleshooting babyyyyy
        console.log("File name error. getCurrentHTMLFileName not found. Search error at function checkWindowName")
    }

    return variable;
}

// Example usage:
var result = checkWindowName();
console.log("Variable value: " + result);
console.log("china - 32, america - 181, france - 57")

//*****************************************************************************************************************************************************************************************
//*****************************************************************************************************************************************************************************************
//*****************************************************************************************************************************************************************************************
async function fetchRandomCountry(result) {
    const url = 'https://country-facts.p.rapidapi.com/all';
    const options = {
        method: 'GET',
        headers: {
            'X-RapidAPI-Key': '4930bc5990msha1f4a2c34e40a4ap14a552jsna147eabe475e', //989357a6e1msh70e2b039d41607ap178352jsn5def265b8212
            'X-RapidAPI-Host': 'country-facts.p.rapidapi.com'
        }
    };

    try {
        const response = await fetch(url, options);   //fetch
        const data = await response.json();           //convert to json

        const countries = Object.keys(data);          //extract all the keys from an object and return them as an array.

        console.log(data);                            //console log

        //const result = countries[Math.floor(Math.random() * countries.length)]; //rndm country number from the available ones

        console.log(result);

        const randomCountry = data[result].name.common; //data[numbercountry].name.common
        const randomCountrySize = data[result].area;  //area
        const randomCountryPopulation = data[result].population;  //population
        const randomCountryOfficialName = data[result].name.official; //official country name
        const randomCountryRegion = data[result].region; //Country region
        const randomCountrySubRegion = data[result].subregion; //Country subregion
        const randomCountryUnStatus = data[result].unMember; //Country united nations status

        const countryNameElement = document.getElementById('country-name'); //get element from html
        const displayedFact = document.getElementById('fact'); //get element from html

        function randomizeFact() {
            var chosenFact = Math.floor(Math.random() * 4) + 1;
            return chosenFact;
        }

        var randomVariable = randomizeFact();
        if (randomVariable == 1) {
            fact = populationFact1(randomCountryPopulation, randomCountry, randomCountrySize);
        }
        if (randomVariable == 2) {
            fact = nameFact1(randomCountry, randomCountryOfficialName);

        }
        if (randomVariable == 3) {
            fact = locationFact1(randomCountry, randomCountryRegion, randomCountrySubRegion);

        }
        if (randomVariable == 4) {
            fact = UnStatusFact1(randomCountry, randomCountryUnStatus);

        }
        else {
            console.log("randomizing facts error"); //it gives an error every time but fuck it, it works and actually gives out randomVariable number for the facts
        }

        console.log(randomVariable);

        countryNameElement.textContent = randomCountry;                     //assign the var to the html
        displayedFact.textContent = fact;                                   //display fact

    } catch (error) {           //else error
        console.error(error);
    }
}

//*****************************************************************************************************************************************************************************************
//*****************************************************************************************************************************************************************************************
//call the whole thing cause mf doesn't work if outside a function scope
fetchRandomCountry(result);

// functions for facts *********************************************************************************************************************
//population fact*********************************************
function populationFact1(randomCountryPopulation, randomCountry, randomCountrySize) {
    var randomCountryPopulationNumber = parseInt(randomCountryPopulation); //parse the string number

    if (randomCountry != 'China') {
        randomCountryPopulationNumber = randomCountryPopulationNumber * 1000000;
    }
    else {
        randomCountryPopulationNumber = randomCountryPopulationNumber * 1000000000; //china's population in the array is 1 for 1bn not 1mil, which is the case with all countries
    }

    console.log(randomCountryPopulationNumber, randomCountrySize)
    var density = randomCountryPopulationNumber / randomCountrySize;

    density = Math.round(density);

    if (density <= 19493) //country can't be more dense than Monaco
        return `Did you know that ${randomCountry}'s population is ${randomCountryPopulation}. This is roughly ${density} people per km2.`
    else
        return `Did you know that ${randomCountry}'s population is ${randomCountryPopulation}.`
}

//Official name fact*********************************************
function nameFact1(randomCountry, randomCountryOfficialName) {

    return `Did you know that ${randomCountry}'s official name is ${randomCountryOfficialName}`
}

//country location fact*********************************************
function locationFact1(randomCountry, randomCountryRegion, randomCountrySubRegion) {
    return `Did you know that ${randomCountry} is located in ${randomCountryRegion} in the ${randomCountrySubRegion} region.`
}

//country UNstatus fact*********************************************
function UnStatusFact1(randomCountry, randomCountryUnStatus) {
    const unstatus = randomCountryUnStatus;
    if (unstatus == true)
        return `Did you know that ${randomCountry} is a member of the United Nations.`
    else
        return `Did you know that ${randomCountry} is a not member of the United Nations.`
}
//*****************************************************************************************************************************************************************************************