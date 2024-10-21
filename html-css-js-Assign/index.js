const API_URL = 'https://restcountries.com/v3.1/all';
const cardsContainer = document.getElementById('cardsContainer');
const searchInput = document.getElementById('search');
const sortButton = document.getElementById('sortButton');
const selectValue=document.getElementById('selectorr');

let countryData = [];
let isAscending = true; 

async function fetchData() {
    try{     
        const response = await fetch(API_URL);
        const data = await response.json();
        countryData = data;
        hideLoader();
        renderCards(countryData);  
    } catch (error) {
        console.error("Error fetching data: ", error);
    }
}

function renderCards(data) {
    cardsContainer.innerHTML = '';  

    data.forEach(country => {
        const { name, flags, population, region } = country;
     
        const card = document.createElement('div');
        card.className = 'card';
   
        card.innerHTML = `
            <img src="${flags.svg}" alt="Flag of ${name.common}" class="flag">
            <h2>${name.common}</h2>
            <p><strong>Population:</strong> ${population.toLocaleString()}</p>
            <p><strong>Region:</strong> ${region}</p>
        `;
        cardsContainer.appendChild(card);
    });
}

searchInput.addEventListener('input', () => {
    const searchTerm = searchInput.value.toLowerCase();
    const filteredData = countryData.filter(country => 
        country.name.common.toLowerCase().includes(searchTerm)
    );
    renderCards(filteredData);
});

sortButton.addEventListener('click', (selectValue) => {
    if(selectValue.value=='Country'){
        const sortedData = countryData.sort((a, b) => {
            if (isAscending) {
                return a.name.common.localeCompare(b.name.common);
            } else {
                return b.name.common.localeCompare(a.name.common);
            }
        });
    }else if(selectValue.value=='Population'){
        const sortedData = countryData.sort((a, b) => {
            if (isAscending) {
                return a.population.common.localeCompare(b.population.common);
            } else {
                return b.population.common.localeCompare(a.population.common);
            }
        });
    }else if(selectValue.value=='Region'){
        const sortedData = countryData.sort((a, b) => {
            if (isAscending) {
                return a.region.common.localeCompare(b.region.common);
            } else {
                return b.region.common.localeCompare(a.region.common);
            }
        });
    }
    
    isAscending = !isAscending;  
    sortButton.innerHTML = `Sort by Country Name ${isAscending ? '&#x25B2;' : '&#x25BC;'}`;
    renderCards(sortedData);
});

function hideLoader(){
    const load = document.querySelector("#loadingBar");
    load.style.display = "none";
}

fetchData();    

