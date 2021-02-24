import mapboxgl from 'mapbox-gl';

const addressFinder = () => {

  const profileKey = "pk.eyJ1IjoicmFwaGFlbC12aWxhc2VjYSIsImEiOiJja2tpZTBkanQwazF4MnVrN2Y1Z3pscjFyIn0.-GqQsj9xbcgGsqzMZIOA1A";
  const btn = document.querySelector("#submit-button");
  const input = document.querySelector("#address");
  const results = document.querySelector("#results");


  input.addEventListener("keyup", (event) => {
    results.innerHTML = "";
    fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${input.value}.json?proximity=2.333333,48.866667&country=FR&access_token=${profileKey}`)
      .then(response => response.json())
      .then((data) => {
        const places = data.features;
        places.forEach((place) => {
          results.insertAdjacentHTML("beforeend", `<li>${place.place_name}</li>`);
        });
        const elements = document.querySelectorAll("li");
        elements.forEach(element => element.addEventListener("click", () => {
          input.value = element.innerText;
          results.innerHTML = "";
        }));
      });
  });

}

export { addressFinder };
