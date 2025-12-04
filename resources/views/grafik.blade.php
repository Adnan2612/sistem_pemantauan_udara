@extends('layouts.app')
@section('title', 'Grafik Pemantauan Udara')
@section('content')

{{-- === HEADER === --}}
<div class="mb-6 animate-fade-in">
  <h2 class="text-3xl font-bold text-blue-700 mb-2">📈 Grafik Pemantauan Kualitas Udara</h2>
  <p class="text-gray-600">Menampilkan tren suhu, kelembaban, PM10, dan indeks kualitas udara secara lengkap.</p>
</div>

@php
  $latest = \App\Models\SensorData::latest('waktu')->first();
  $suhu = $latest->suhu ?? 0;
  $kelembaban = $latest->kelembaban ?? 0;
  $pm10 = $latest->pm10 ?? 0;
  $aqi = $latest->aqi ?? 0;
  $kategori = $latest->kategori ?? '-';

  switch ($kategori) {
      case 'Baik': $warna = 'green'; break;
      case 'Sedang': $warna = 'yellow'; break;
      case 'Tidak Sehat': $warna = 'orange'; break;
      case 'Sangat Tidak Sehat': $warna = 'red'; break;
      case 'Berbahaya': $warna = 'purple'; break;
      default: $warna = 'gray'; break;
  }
@endphp

{{-- === KARTU NILAI TERKINI === --}}
<div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">

  <div class="bg-gradient-to-br from-red-500 to-red-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">Suhu Udara</h3>
    <div class="text-4xl font-bold">{{ $suhu }}°C</div>
  </div>

  <div class="bg-gradient-to-br from-blue-500 to-blue-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">Kelembaban</h3>
    <div class="text-4xl font-bold">{{ $kelembaban }}%</div>
  </div>

  <div class="bg-gradient-to-br from-green-500 to-green-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">PM10 (Debu)</h3>
    <div class="text-4xl font-bold">{{ $pm10 }} µg/m³</div>
  </div>

  <div class="bg-gradient-to-br from-{{ $warna }}-500 to-{{ $warna }}-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold mb-1">Indeks Kualitas Udara (AQI)</h3>
    <div class="text-4xl font-bold">{{ $aqi }}</div>
    <p class="text-sm opacity-90">{{ $kategori }}</p>
  </div>
</div>

{{-- === GRAFIK FULL DATA === --}}
<div class="bg-white rounded-xl shadow-lg p-6 mb-8">

  <div class="flex justify-between items-center mb-4">
    <h3 class="text-xl font-bold text-blue-700">📊 Grafik Semua Data Sensor</h3>

    <button onclick="loadChart()" 
            class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
            🔄 Refresh Grafik
    </button>
  </div>

  <div id="chartLoading" class="text-gray-500 text-center py-4 hidden">
    Memuat grafik...
  </div>

  <canvas id="chartSensor" height="120"></canvas>
</div>

{{-- === TABEL 100 DATA TERAKHIR === --}}
<div class="bg-white rounded-xl shadow-lg p-6">

  <h3 class="text-xl font-bold mb-4 text-blue-700">📋 100 Data Sensor Terbaru</h3>

  <input id="searchInput" type="text" onkeyup="filterTable()" 
         placeholder="Cari waktu / kategori / nilai..."
         class="border p-2 rounded-lg w-full mb-3 shadow-sm">

  <div class="max-h-96 overflow-y-scroll border rounded-lg">
    <table class="table-auto w-full border-collapse border text-center">
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

      <tbody id="tabelData">
        @foreach (\App\Models\SensorData::orderBy('waktu', 'desc')->take(100)->get() as $row)
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

{{-- ========================================= --}}
{{--           JAVASCRIPT UNTUK GRAFIK          --}}
{{-- ========================================= --}}
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
let chart;

// MUAT DATA GRAFIK DARI API
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
                        { label: 'PM10 (µg/m³)', borderColor: 'green', data: data.pm10, fill: false }
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

// Load grafik pertama kali
loadChart();

// Auto refresh setiap 10 detik
setInterval(loadChart, 10000);


// FILTER TABEL
function filterTable() {
  const input = document.getElementById("searchInput").value.toLowerCase();
  const rows = document.querySelectorAll("#tabelData tr");

  rows.forEach(row => {
    const text = row.innerText.toLowerCase();
    row.style.display = text.includes(input) ? "" : "none";
  });
}
</script>

{{-- === ANIMASI CSS === --}}
<style>
@keyframes fade-in { 
  from {opacity:0; transform:translateY(10px);} 
  to {opacity:1; transform:translateY(0);} 
}
.animate-fade-in { animation: fade-in 0.8s ease forwards; }
</style>

@endsection
