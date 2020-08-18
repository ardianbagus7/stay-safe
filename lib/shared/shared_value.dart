part of 'shared.dart';

String apiKey = 'eb75505c4da615d15cdaac88b23482a1';
String imageBaseUrl = 'https://image.tmdb.org/t/p/';

String geoApi = "AIzaSyBTepnMb55p_z6pCpW2DGp0bWW3HGcbLU0";

String mapStyle = "[{\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#1d2c4d\"}]},{\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#8ec3b9\"}]},{\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#1a3646\"}]},{\"featureType\":\"administrative\",\"elementType\":\"geometry\",\"stylers\":[{\"visibility\":\"off\"}]},{\"featureType\":\"administrative.country\",\"elementType\":\"geometry.stroke\",\"stylers\":[{\"color\":\"#4b6878\"}]},{\"featureType\":\"administrative.land_parcel\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#64779e\"}]},{\"featureType\":\"administrative.province\",\"elementType\":\"geometry.stroke\",\"stylers\":[{\"color\":\"#4b6878\"}]},{\"featureType\":\"landscape.man_made\",\"elementType\":\"geometry.stroke\",\"stylers\":[{\"color\":\"#334e87\"}]},{\"featureType\":\"landscape.natural\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#023e58\"}]},{\"featureType\":\"poi\",\"stylers\":[{\"visibility\":\"off\"}]},{\"featureType\":\"poi\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#283d6a\"}]},{\"featureType\":\"poi\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#6f9ba5\"}]},{\"featureType\":\"poi\",\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#1d2c4d\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"geometry.fill\",\"stylers\":[{\"color\":\"#023e58\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#3C7680\"}]},{\"featureType\":\"road\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#304a7d\"}]},{\"featureType\":\"road\",\"elementType\":\"labels.icon\",\"stylers\":[{\"visibility\":\"off\"}]},{\"featureType\":\"road\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#98a5be\"}]},{\"featureType\":\"road\",\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#1d2c4d\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#2c6675\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"geometry.stroke\",\"stylers\":[{\"color\":\"#255763\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#b0d5ce\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#023e58\"}]},{\"featureType\":\"transit\",\"stylers\":[{\"visibility\":\"off\"}]},{\"featureType\":\"transit\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#98a5be\"}]},{\"featureType\":\"transit\",\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#1d2c4d\"}]},{\"featureType\":\"transit.line\",\"elementType\":\"geometry.fill\",\"stylers\":[{\"color\":\"#283d6a\"}]},{\"featureType\":\"transit.station\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#3a4762\"}]},{\"featureType\":\"water\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#0e1626\"}]},{\"featureType\":\"water\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#4e6d70\"}]}]";

PageEvent prevPageEvent;

// List<String> kategori = [
//   'Semua',
//   'Makanan',
//   'Minuman',
//   'Peralatan',
//   'Tanaman',
//   'Hewan'
// ];

// List<String> splashTitle = [
//   'Pergi Belanja Dengan Aman',
//   'Cari Tempat Yang Aman Untuk Berjualan'
// ];

// List<String> splashSubtitle = [
//   'Kamu bisa mencari pedagang dengan tetap waspada dan aman, karena pada Map akan terlihat zona merah pasien covid-19 yang terintegrasi dengan data pemerintah.',
//   'Kamu bisa mencari tempat berjualan yang aman untuk menghidari daerah rawan covid-19, tetapi tetap patuhi protokol kesehatan ya.'
// ];

List<String> kategori = [
  'All',
  'Foods',
  'Drinks',
  'Appliances',
  'Plants',
  'Animals'
];

List<String> splashTitle = [
  'Find peddler safely',
  'Find a safe place to sell'
];

List<String> splashSubtitle = [
  'You can search for peddlers by staying alert and safe, because on the map you will see a red zone for Covid-19 patients which is integrated with government data.',
  'You can find a safe place to sell to avoid areas prone to COVID-19, but still adhere to health protocols.'
];
