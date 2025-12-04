<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SensorData;

class DashboardController extends Controller
{
    public function index()
    {
        $latest = SensorData::latest('waktu')->first();

        return view('dashboard', [
            'suhu' => $latest->suhu ?? 0,
            'kelembaban' => $latest->kelembaban ?? 0,
            'pm10' => $latest->pm10 ?? 0,
            'aqi' => $latest->aqi ?? 0,
            'kategori' => $latest->kategori ?? '-',
        ]);
    }
}
