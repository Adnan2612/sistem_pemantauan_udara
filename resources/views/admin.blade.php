@extends('layouts.app')
@section('title', 'Admin Panel')
@section('content')
<h2 class="text-2xl font-bold mb-4 text-blue-700">⚙️ Halaman Admin</h2>

<div class="grid grid-cols-2 gap-6">
  <div class="bg-white shadow-lg p-4 rounded-lg">
    <h3 class="text-lg font-semibold mb-2">Manajemen Pengguna</h3>
    <p class="text-gray-600 mb-4">Tambah atau hapus akun pengguna sistem.</p>
    <button class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">Kelola Pengguna</button>
  </div>

  <div class="bg-white shadow-lg p-4 rounded-lg">
    <h3 class="text-lg font-semibold mb-2">Manajemen Lokasi Sensor</h3>
    <p class="text-gray-600 mb-4">Atur lokasi alat pemantauan udara.</p>
    <button class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">Atur Lokasi</button>
  </div>
</div>
@endsection
