<?php

namespace App\Http\Controllers;

use App\Models\SensorData;

class SensorController extends Controller
{
    public function index()
    {
        $data = SensorData::latest('waktu')->take(10)->get();
        return view('sensor', compact('data'));
    }
}
