<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\LogAktivitas;
use CodeIgniter\HTTP\ResponseInterface;

class Dashboard extends BaseController
{
    protected $logModel;

    public function __construct()
    {
        $this->logModel = new LogAktivitas();
    }

    public function index()
    {
        // Check if user is logged in
        if (!session()->get('isLoggedIn')) {
            return redirect()->to('/auth/login');
        }

        // Log aktivitas akses dashboard
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Mengakses halaman Dashboard'
        );

        $data = [
            'user' => [
                'username' => session()->get('username'),
                'nama_lengkap' => session()->get('nama_lengkap'),
                'role' => session()->get('role')
            ]
        ];

        return view('dashboard/index', $data);
    }
}
