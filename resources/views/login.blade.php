<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sistem Pemantauan Udara</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-blue-600 to-blue-900 flex items-center justify-center min-h-screen text-white">

  <div class="bg-white text-gray-800 p-8 rounded-2xl shadow-lg w-96">
    <h2 class="text-2xl font-bold mb-6 text-center text-blue-700">🌤️ Login Sistem Pemantauan Udara</h2>

    @if(session('error'))
      <div class="bg-red-100 text-red-600 p-3 rounded mb-4">
        {{ session('error') }}
      </div>
    @endif

    <form action="/login" method="POST">
      @csrf
      <div class="mb-4">
        <label for="email" class="block mb-2 font-semibold">Email</label>
        <input type="email" id="email" name="email" class="w-full border rounded p-2" placeholder="admin@udara.com" required>
      </div>
      <div class="mb-6">
        <label for="password" class="block mb-2 font-semibold">Password</label>
        <input type="password" id="password" name="password" class="w-full border rounded p-2" placeholder="********" required>
      </div>
      <button type="submit" class="bg-blue-700 hover:bg-blue-800 text-white font-semibold w-full py-2 rounded-lg transition">
        Masuk
      </button>
    </form>
  </div>

</body>
</html>
