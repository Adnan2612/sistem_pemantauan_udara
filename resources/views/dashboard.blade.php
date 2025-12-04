@extends('layouts.app')
@section('title', 'Dashboard Utama')
@section('content')

{{-- === LOADING SCREEN === --}}
<div id="loading-screen" class="fixed inset-0 flex items-center justify-center bg-white z-40">
  <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-blue-600"></div>
</div>

<script>
  window.addEventListener('load', function() {
    const loader = document.getElementById('loading-screen');
    setTimeout(() => loader.classList.add('hidden'), 500);
  });
</script>

{{-- === HEADING === --}}
<div class="mb-6 animate-fade-in relative z-10">
  <h2 class="text-3xl font-bold text-blue-700 mb-2">🌤️ Sistem Pemantauan Udara</h2>
  <p class="text-gray-600">Pemantauan kualitas udara berdasarkan parameter suhu, kelembaban, dan partikel PM10.</p>
</div>

@php
  $suhu = $suhu ?? 0;
  $kelembaban = $kelembaban ?? 0;
  $pm10 = $pm10 ?? 0;
  $aqi = $aqi ?? 0;
  $kategori = $kategori ?? '-';

  switch ($kategori) {
      case 'Baik': $warna = 'green'; $pesan = 'Kualitas udara baik, aman untuk beraktivitas.'; break;
      case 'Sedang': $warna = 'yellow'; $pesan = 'Kualitas udara sedang. Hindari aktivitas berat.'; break;
      case 'Tidak Sehat': $warna = 'orange'; $pesan = 'Udara tidak sehat! Kurangi aktivitas luar.'; break;
      case 'Sangat Tidak Sehat': $warna = 'red'; $pesan = 'Udara sangat tidak sehat! Gunakan masker.'; break;
      case 'Berbahaya': $warna = 'purple'; $pesan = 'Udara berbahaya! Tetap di dalam ruangan.'; break;
      default: $warna = 'gray'; $pesan = 'Belum ada data.'; break;
  }
@endphp

{{-- === KARTU STATISTIK === --}}
<div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 relative z-10">
  <div class="bg-gradient-to-br from-red-500 to-red-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">Suhu Udara</h3>
    <div class="text-4xl font-bold">{{ number_format($suhu, 1) }}°C</div>
  </div>

  <div class="bg-gradient-to-br from-blue-500 to-blue-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">Kelembaban</h3>
    <div class="text-4xl font-bold">{{ number_format($kelembaban, 1) }}%</div>
  </div>

  <div class="bg-gradient-to-br from-green-500 to-green-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">PM10 (Debu)</h3>
    <div class="text-4xl font-bold">{{ number_format($pm10, 1) }} µg/m³</div>
  </div>

  <div class="bg-gradient-to-br from-{{ $warna }}-500 to-{{ $warna }}-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">Indeks Kualitas Udara (AQI)</h3>
    <div class="text-4xl font-bold">{{ $aqi }}</div>
    <p class="text-sm opacity-90">{{ $kategori }}</p>
  </div>
</div>

{{-- === GRAFIK FULL DATA === --}}
<div class="bg-white rounded-xl shadow-lg p-6 mb-8 animate-fade-in relative z-10">
  <div class="flex justify-between items-center mb-4">
    <h3 class="text-xl font-bold text-blue-700">📈 Grafik Semua Data Sensor</h3>
    <button onclick="loadChart()" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">🔄 Refresh Grafik</button>
  </div>

  <div id="chartLoading" class="text-center text-gray-500 py-4 hidden">Memuat grafik...</div>
  <canvas id="chartSensor" height="120"></canvas>
</div>

{{-- === TABEL 100 DATA TERAKHIR === --}}
<div class="bg-white rounded-xl shadow-lg p-6 animate-fade-in relative z-10">
  <h3 class="text-xl font-bold mb-4 text-blue-700">📋 100 Data Sensor Terbaru</h3>

  {{-- Search --}}
  <input id="searchInput" onkeyup="filterTable()" type="text" placeholder="Cari waktu / kategori..." 
         class="border p-2 mb-3 w-full rounded-lg shadow-sm">

  <div class="max-h-96 overflow-y-scroll border rounded-lg">
    <table class="table-auto w-full text-center">
      <thead class="bg-blue-600 text-white">
        <tr>
          <th class="p-3 border">Waktu</th>
          <th class="p-3 border">Suhu</th>
          <th class="p-3 border">Kelembaban</th>
          <th class="p-3 border">PM10</th>
          <th class="p-3 border">AQI</th>
          <th class="p-3 border">Kategori</th>
        </tr>
      </thead>

      <tbody id="dataTable">
        @foreach (\App\Models\SensorData::orderBy('waktu','desc')->take(100)->get() as $row)
        <tr class="hover:bg-gray-50">
          <td class="border p-2">{{ \Carbon\Carbon::parse($row->waktu)->format('H:i') }}</td>
          <td class="border p-2">{{ $row->suhu }}</td>
          <td class="border p-2">{{ $row->kelembaban }}</td>
          <td class="border p-2">{{ $row->pm10 }}</td>
          <td class="border p-2">{{ $row->aqi }}</td>
          <td class="border p-2">{{ $row->kategori }}</td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </div>
</div>

{{-- === JAVASCRIPT GRAFIK === --}}
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
let chart;

function loadChart() {
    document.getElementById('chartLoading').classList.remove('hidden');

    fetch('/api/chart-data')
        .then(res => res.json())
        .then(data => {
            document.getElementById('chartLoading').classList.add('hidden');

            const ctx = document.getElementById('chartSensor').getContext('2d');
            if (chart) chart.destroy();

            chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: data.labels,
                    datasets: [
                        { label: 'Suhu (°C)', borderColor: 'red', data: data.suhu, fill: false },
                        { label: 'Kelembaban (%)', borderColor: 'blue', data: data.kelembaban, fill: false },
                        { label: 'PM10 (µg/m³)', borderColor: 'green', data: data.pm10, fill: false },
                    ]
                },
                options: {
                    responsive: true,
                    interaction: { mode: 'index', intersect: false },
                    plugins: { legend: { position: 'bottom' } },
                    scales: { y: { beginAtZero: true } }
                }
            });
        });
}

// load grafik pertama kali
loadChart();

// auto refresh setiap 10 detik
setInterval(loadChart, 10000);


// === SEARCH FILTER TABEL ===
function filterTable() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const rows = document.querySelectorAll("#dataTable tr");

    rows.forEach(row => {
        const text = row.innerText.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
    });
}
</script>

{{-- === POPUP INFO === --}}
<div id="aqi-popup" class="fixed top-20 right-5 hidden bg-white border-l-4 p-4 rounded-lg shadow-lg w-80 z-50">
  <p id="aqi-popup-text" class="text-gray-800 font-semibold"></p>
</div>

<script>
const kategori = "{{ $kategori }}";
const pesan = "{{ $pesan }}";
const warna = "{{ $warna }}";

window.addEventListener('load', () => {
  const popup = document.getElementById('aqi-popup');
  const text = document.getElementById('aqi-popup-text');
  popup.classList.remove('hidden');
  popup.classList.add(`border-${warna}-600`);
  text.innerHTML = `🌍 <b>Indeks Kualitas Udara:</b> ${kategori}<br>${pesan}`;
  setTimeout(() => popup.style.opacity = 0, 7000);
});
</script>

<style>
@keyframes fade-in { from {opacity:0; transform:translateY(10px);} to {opacity:1; transform:translateY(0);} }
.animate-fade-in { animation: fade-in 0.8s ease forwards; }
</style>

@endsection
