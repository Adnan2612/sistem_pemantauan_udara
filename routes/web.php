<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Models\SensorData;

/*
|--------------------------------------------------------------------------
| Halaman Login
|--------------------------------------------------------------------------
*/
Route::get('/', function () {
    return view('login');
})->name('login');

Route::post('/login', function (Request $request) {

    // Daftar akun
    $accounts = [
        'admin' => [
            'email' => 'adminnanda@gmail.com',
            'password' => 'admin123',
            'role' => 'admin'
        ],
        'user' => [
            'email' => 'user@gmail.com',
            'password' => 'user123',
            'role' => 'user'
        ]
    ];

    // Validasi login admin
    if ($request->email === $accounts['admin']['email'] 
        && $request->password === $accounts['admin']['password']) {

        session([
            'logged_in' => true,
            'role' => 'admin',
            'email' => $request->email
        ]);

        return redirect('/dashboard');
    }

    // Validasi login user biasa
    if ($request->email === $accounts['user']['email'] 
        && $request->password === $accounts['user']['password']) {
        
        session([
            'logged_in' => true,
            'role' => 'user',
            'email' => $request->email
        ]);

        return redirect('/dashboard');
    }

    // Jika login gagal
    return back()->with('error', 'Email atau password salah!');
});

Route::get('/logout', function () {
    session()->flush();
    return redirect('/');
});


/*
|--------------------------------------------------------------------------
| Halaman Utama Website (Proteksi Login)
|--------------------------------------------------------------------------
*/
Route::middleware(['web'])->group(function () {

    // DASHBOARD
    Route::get('/dashboard', function () {
        if (!session('logged_in')) return redirect('/');

        $data = SensorData::latest('waktu')->first();

        return view('dashboard', [
            'suhu' => $data->suhu ?? 0,
            'kelembaban' => $data->kelembaban ?? 0,
            'pm10' => $data->pm10 ?? 0,
            'aqi' => $data->aqi ?? 0,
            'kategori' => $data->kategori ?? '-',
        ]);
    });

    // GRAFIK
    Route::get('/grafik', function () {
        if (!session('logged_in')) return redirect('/');
        return view('grafik');
    });

    // SENSOR
    Route::get('/sensor', function () {
        if (!session('logged_in')) return redirect('/');

        $data = SensorData::orderBy('waktu', 'desc')->take(30)->get();
        return view('sensor', compact('data'));
    });
});


/*
|--------------------------------------------------------------------------
| HALAMAN ADMIN (Hanya Admin)
|--------------------------------------------------------------------------
*/
Route::get('/admin', function () {

    if (!session('logged_in')) return redirect('/');

    // Jika user biasa coba masuk admin
    if (session('role') !== 'admin') {
        return back()->with('error', '⚠️ Anda tidak memiliki akses ke halaman admin.');
    }

    return view('admin');
});


/*
|--------------------------------------------------------------------------
| API ESP32
|--------------------------------------------------------------------------
*/
Route::post('/api/sensor', function (Request $request) {

    SensorData::create([
        'sensor_id' => 1,
        'suhu' => $request->suhu,
        'kelembaban' => $request->kelembaban,
        'pm10' => $request->pm10,
        'aqi' => $request->aqi,
        'kategori' => $request->kategori,
        'waktu' => now(),
    ]);

    return response()->json([
        'status' => 'success',
        'message' => 'Data berhasil disimpan!'
    ]);
});


/*
|--------------------------------------------------------------------------
| API Grafik — Mengambil seluruh data sensor
|--------------------------------------------------------------------------
*/
Route::get('/api/chart-data', function () {

    $data = SensorData::orderBy('waktu', 'asc')->get();

    return response()->json([
        'labels' => $data->pluck('waktu')->map(fn($w) => \Carbon\Carbon::parse($w)->format('H:i'))->toArray(),
        'suhu' => $data->pluck('suhu')->toArray(),
        'kelembaban' => $data->pluck('kelembaban')->toArray(),
        'pm10' => $data->pluck('pm10')->toArray(),
    ]);
});
