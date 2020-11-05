// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

import mapboxgl from 'mapbox-gl';


const baseUrl = `https://api.mapbox.com/geocoding/v5/mapbox.places/`;
mapboxgl.accessToken = mapBoxKey;

const form = document.querySelector('form');
const input = document.querySelector('#location');
const results = document.querySelector('#result');

const drawMap = (long, lat) => {
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v9',
    center: [29.030378, 41.144889],
    zoom: 12
  });
  new mapboxgl.Marker()
    .setLngLat([29.030378, 41.144889])
    .addTo(map);
};

const displayResults = (long, lat) => {
  results.innerHTML = '';
  const list = `<li class="list-inline-item">Long =${long}</li>
                <li class="list-inline-item">Lat = ${lat}</li>`;
  results.insertAdjacentHTML("beforeend", list);
  drawMap(long, lat);
};

const getLongLat = (data) => {
  const longitude = data.features[0].geometry.coordinates[0];
  const latitude = data.features[0].geometry.coordinates[1];
  displayResults(longitude, latitude);
};

const callMapBox = (search) => {
  fetch(`${baseUrl}${search}.json?access_token=${mapBoxKey}`)
    .then(response => response.json())
    .then(getLongLat)
    .catch((error) => {
      console.log(error);
    });
};

const handleSubmit = (event) => {
  event.preventDefault();
  callMapBox(input.value);
};

form.addEventListener('submit', handleSubmit);
