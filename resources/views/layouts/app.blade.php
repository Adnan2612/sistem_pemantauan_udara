<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>@yield('title', 'Sistem Pemantauan Udara')</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100">

  {{-- ====================== NAVBAR ====================== --}}
  <nav class="bg-blue-700 text-white p-4 flex justify-between items-center shadow-md">
    <h1 class="text-lg font-bold">🌤️ Pemantauan Udara</h1>

    <div class="space-x-4">
      <a href="/dashboard" class="hover:underline">Dashboard</a>
      <a href="/grafik" class="hover:underline">Grafik</a>
      <a href="/sensor" class="hover:underline">Sensor</a>

      {{-- ======== HANYA ADMIN YANG BISA MELIHAT MENU ADMIN ======== --}}
      @if(session('role') === 'admin')
        <a href="/admin" class="hover:underline font-semibold text-yellow-300">Admin</a>
      @endif

      <a href="/logout" class="hover:underline text-red-200">Logout</a>
    </div>
  </nav>

  {{-- ====================== MAIN CONTENT ====================== --}}
  <main class="p-6">
    @yield('content')
  </main>

</body>
</html>
