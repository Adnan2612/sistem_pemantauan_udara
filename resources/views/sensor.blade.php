@extends('layouts.app')
@section('title', 'Data Sensor')
@section('content')

{{-- === HEADER === --}}
<div class="mb-6 animate-fade-in">
  <h2 class="text-3xl font-bold text-blue-700 mb-2">📟 Daftar Sensor Pemantauan Udara</h2>
  <p class="text-gray-600">Informasi lengkap setiap sensor dan data terakhir yang direkam.</p>
</div>

@php
use App\Models\Sensor;
use App\Models\SensorData;

$jumlah_sensor = Sensor::count();
$aktif = Sensor::where('status', 'Aktif')->count();
$offline = Sensor::where('status', 'Offline')->count();
$rata_pm10 = round(SensorData::avg('pm10') ?? 0, 1);

$sensors = Sensor::all();
@endphp

{{-- === KARTU RINGKAS === --}}
<div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
  <div class="bg-gradient-to-br from-blue-500 to-blue-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold">Total Sensor</h3>
    <div class="text-4xl font-bold">{{ $jumlah_sensor }}</div>
  </div>

  <div class="bg-gradient-to-br from-green-500 to-green-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold">Aktif</h3>
    <div class="text-4xl font-bold">{{ $aktif }}</div>
  </div>

  <div class="bg-gradient-to-br from-red-500 to-red-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold">Offline</h3>
    <div class="text-4xl font-bold">{{ $offline }}</div>
  </div>

  <div class="bg-gradient-to-br from-yellow-500 to-yellow-600 text-white p-6 rounded-xl shadow-md">
    <h3 class="font-semibold">Rata-rata PM10</h3>
    <div class="text-4xl font-bold">{{ $rata_pm10 }} µg/m³</div>
  </div>
</div>

{{-- === MODE OTOMATIS === --}}
<div class="flex justify-end mb-3">
  <button id="toggleAuto" 
          class="bg-blue-600 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-700">
      🔄 Auto Mode: ON
  </button>
</div>

{{-- === TABEL SENSOR === --}}
<div class="bg-white rounded-xl shadow-lg p-6 animate-fade-in">
  <h3 class="text-xl font-bold mb-4 text-blue-700">📋 Informasi Sensor</h3>

  <div class="max-h-[450px] overflow-y-scroll rounded-lg border" id="scrollBox">
    <table class="table-auto w-full border-collapse text-center" id="sensorTable">
      <thead class="bg-blue-600 text-white sticky top-0">
        <tr>
          <th class="p-3 border">ID Sensor</th>
          <th class="p-3 border">Lokasi</th>
          <th class="p-3 border">Status</th>
          <th class="p-3 border">Suhu</th>
          <th class="p-3 border">Kelembaban</th>
          <th class="p-3 border">PM10</th>
          <th class="p-3 border">AQI</th>
          <th class="p-3 border">Kategori</th>
          <th class="p-3 border">Keterangan</th>
        </tr>
      </thead>

      <tbody>
        @forelse ($sensors as $sensor)
          @php
            $data = SensorData::where('sensor_id', $sensor->id)->latest('waktu')->first();
            $suhu = $data->suhu ?? '-';
            $kelembaban = $data->kelembaban ?? '-';
            $pm10 = $data->pm10 ?? '-';
            $aqi = $data->aqi ?? '-';
            $kategori = $data->kategori ?? 'Tidak Ada Data';

            switch ($kategori) {
                case 'Baik': $warna = 'text-green-600'; $ket = 'Udara bersih dan sehat'; break;
                case 'Sedang': $warna = 'text-yellow-600'; $ket = 'Masih aman untuk aktivitas ringan'; break;
                case 'Tidak Sehat': $warna = 'text-orange-600'; $ket = 'Kurangi aktivitas luar ruangan'; break;
                case 'Sangat Tidak Sehat': $warna = 'text-red-600'; $ket = 'Gunakan masker'; break;
                case 'Berbahaya': $warna = 'text-purple-600'; $ket = 'Tetap di dalam ruangan'; break;
                default: $warna = 'text-gray-600'; $ket = 'Data belum tersedia'; break;
            }
          @endphp

          <tr class="table-row-item transition">
            <td class="border p-2">{{ $sensor->kode_sensor }}</td>
            <td class="border p-2">{{ $sensor->lokasi }}</td>
            <td class="border p-2 {{ $sensor->status === 'Aktif' ? 'text-green-600' : 'text-red-600' }}">{{ $sensor->status }}</td>
            <td class="border p-2">{{ $suhu }}</td>
            <td class="border p-2">{{ $kelembaban }}</td>
            <td class="border p-2">{{ $pm10 }}</td>
            <td class="border p-2 font-bold {{ $warna }}">{{ $aqi }}</td>
            <td class="border p-2 font-semibold {{ $warna }}">{{ $kategori }}</td>
            <td class="border p-2 text-gray-600">{{ $ket }}</td>
          </tr>

        @empty
          <tr>
            <td colspan="9" class="p-4 text-gray-500">Belum ada data sensor.</td>
          </tr>
        @endforelse
      </tbody>
    </table>
  </div>
</div>

{{-- === AUTOSCROLL + AUTO HIGHLIGHT SCRIPT === --}}
<script>
let autoMode = true;
let currentIndex = 0;

const rows = document.querySelectorAll(".table-row-item");
const scrollBox = document.getElementById("scrollBox");
const toggleBtn = document.getElementById("toggleAuto");

function highlightRow() {
    if (!autoMode || rows.length === 0) return;

    rows.forEach(row => row.classList.remove("bg-yellow-100"));

    const row = rows[currentIndex];
    row.classList.add("bg-yellow-100");

    row.scrollIntoView({ behavior: "smooth", block: "center" });

    currentIndex = (currentIndex + 1) % rows.length;
}

setInterval(highlightRow, 3000);

toggleBtn.addEventListener("click", () => {
    autoMode = !autoMode;
    toggleBtn.innerText = autoMode ? "🔄 Auto Mode: ON" : "⏸ Auto Mode: OFF";
    if (!autoMode) rows.forEach(r => r.classList.remove("bg-yellow-100"));
});
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
