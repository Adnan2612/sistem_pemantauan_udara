<?php

namespace App\Http\Controllers;

class PageController extends Controller
{
    public function dashboard()
    {
        // Data dummy sementara
        $data = [
            ['waktu' => '2025-10-21 08:00:00', 'suhu' => 30.2, 'kelembaban' => 65, 'pm10' => 40, 'status' => 'Baik'],
            ['waktu' => '2025-10-21 09:00:00', 'suhu' => 31.1, 'kelembaban' => 63, 'pm10' => 55, 'status' => 'Sedang'],
            ['waktu' => '2025-10-21 10:00:00', 'suhu' => 32.5, 'kelembaban' => 60, 'pm10' => 75, 'status' => 'Buruk'],
        ];
        return view('dashboard', compact('data'));
    }

    public function grafik()
    {
        // Data dummy untuk grafik
        $data = [
            ['waktu' => '08:00', 'suhu' => 30.2, 'kelembaban' => 65, 'pm10' => 40],
            ['waktu' => '09:00', 'suhu' => 31.1, 'kelembaban' => 63, 'pm10' => 55],
            ['waktu' => '10:00', 'suhu' => 32.5, 'kelembaban' => 60, 'pm10' => 75],
        ];
        return view('grafik', compact('data'));
    }

    public function login()
    {
        return view('login');
    }
}
