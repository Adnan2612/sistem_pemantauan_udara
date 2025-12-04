<?php

namespace App\Http\Controllers;

use App\Models\SensorData;

class GrafikController extends Controller
{
    public function index()
    {
        $data = SensorData::latest('waktu')->take(10)->get();
        return view('grafik', compact('data'));
    }
}
