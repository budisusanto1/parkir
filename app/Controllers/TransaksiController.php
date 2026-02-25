<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Transaksi;
use App\Models\Kendaraan;
use App\Models\Tarif;
use App\Models\AreaParkir;
use App\Models\LogAktivitas;

class TransaksiController extends BaseController
{
    protected $transaksiModel;
    protected $kendaraanModel;
    protected $tarifModel;
    protected $areaModel;
    protected $logModel;

    public function __construct()
    {
        $this->transaksiModel = new Transaksi();
        $this->kendaraanModel = new Kendaraan();
        $this->tarifModel = new Tarif();
        $this->areaModel = new AreaParkir();
        $this->logModel = new LogAktivitas();
    }

    // Cek role untuk akses petugas
    private function checkRole()
    {
        if (!session()->get('isLoggedIn')) {
            return redirect()->to('/auth/login');
        }
        
        // Izinkan petugas, admin, superadmin, dan owner untuk akses cetak struk
        if (!in_array(session()->get('role'), ['petugas', 'admin', 'superadmin', 'owner'])) {
            session()->setFlashdata('error', 'Akses ditolak! Hanya petugas, admin, superadmin, dan owner yang dapat mengakses halaman ini.');
            return redirect()->to('/dashboard');
        }
        
        return null;
    }

    public function index()
    {
        $check = $this->checkRole();
        if ($check) return $check;

        // Log aktivitas
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Mengakses halaman transaksi masuk'
        );

        $data = [
            'title' => 'Transaksi Masuk',
            'area' => $this->areaModel->findAll(),
            'tarif' => $this->tarifModel->findAll()
        ];

        return view('transaksi/masuk', $data);
    }

    public function storeMasuk()
    {
        $check = $this->checkRole();
        if ($check) return $check;

        // Cek kendaraan berdasarkan plat nomor
        $plat_nomor = $this->request->getPost('no_plat');
        $jenis_kendaraan = $this->request->getPost('jenis_kendaraan');
        
        // Cari kendaraan yang sudah ada atau buat baru
        $kendaraan = $this->kendaraanModel->where('plat_nomor', $plat_nomor)->first();
        
        if (!$kendaraan) {
            // Buat kendaraan baru
            $kendaraanData = [
                'plat_nomor' => $plat_nomor,
                'jenis_kendaraan' => $jenis_kendaraan,
                'pemilik' => 'Tidak Diketahui',
                'warna' => '-'
            ];
            $this->kendaraanModel->save($kendaraanData);
            $id_kendaraan = $this->kendaraanModel->getInsertID();
        } else {
            $id_kendaraan = $kendaraan['id_kendaraan'];
        }

        // Ambil tarif
        $tarif = $this->tarifModel->where('jenis_kendaraan', $jenis_kendaraan)->first();
        $id_tarif = $tarif ? $tarif['id_tarif'] : null;

        $data = [
            'id_kendaraan' => $id_kendaraan,
            'waktu_masuk' => date('Y-m-d H:i:s'),
            'id_tarif' => $id_tarif,
            'id_area' => $this->request->getPost('id_area'),
            'status' => 'masuk',
            'id_user' => session()->get('id_user')
        ];

        if (!$this->transaksiModel->save($data)) {
            session()->setFlashdata('error', 'Gagal menyimpan transaksi: ' . implode(', ', $this->transaksiModel->errors()));
            return redirect()->back()->withInput();
        }

        // Log aktivitas
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Transaksi masuk: ' . $plat_nomor . ' (' . $jenis_kendaraan . ')'
        );

        return redirect()->to('/transaksi')->with('success', 'Transaksi masuk berhasil dicatat');
    }

    public function keluar()
    {
        $check = $this->checkRole();
        if ($check) return $check;

        // Log aktivitas
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Mengakses halaman transaksi keluar'
        );

        $data = [
            'title' => 'Transaksi Keluar',
            'transaksi' => $this->transaksiModel->getTransaksiWithRelations()
        ];

        return view('transaksi/keluar', $data);
    }

    public function processKeluar($id)
    {
        $check = $this->checkRole();
        if ($check) return $check;

        $transaksi = $this->transaksiModel->find($id);
        if (!$transaksi) {
            return redirect()->to('/transaksi/keluar')->with('error', 'Transaksi tidak ditemukan');
        }

        $waktu_keluar = date('Y-m-d H:i:s');
        
        // Update waktu keluar
        $this->transaksiModel->transaksiKeluar($id, $waktu_keluar);
        
        // Ambil tarif untuk menghitung biaya
        $transaksiDetail = $this->transaksiModel->getTransaksiWithRelations($id);
        
        // Debug: Tampilkan data transaksi
        log_message('debug', 'Transaksi detail: ' . json_encode($transaksiDetail));
        
        if (!$transaksiDetail || !isset($transaksiDetail['id_tarif'])) {
            log_message('error', 'Transaksi detail or id_tarif not found');
            return redirect()->to('/transaksi/keluar')->with('error', 'Data transaksi tidak lengkap');
        }
        
        $tarif = $this->tarifModel->find($transaksiDetail['id_tarif']);
        
        // Debug: Tampilkan data tarif
        log_message('debug', 'Tarif data: ' . json_encode($tarif));
        
        if ($tarif && isset($tarif['tarif_per_jam'])) {
            // Hitung biaya menggunakan method baru
            $this->transaksiModel->updateWithBiaya($id, $tarif['tarif_per_jam']);
        } else {
            log_message('error', 'Tarif not found or tarif_per_jam not set. Tarif ID: ' . $transaksiDetail['id_tarif']);
            // Set default tarif jika tidak ditemukan
            $defaultTarif = 5000; // Rp 5.000 per jam
            $this->transaksiModel->updateWithBiaya($id, $defaultTarif);
        }

        // Log aktivitas
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Transaksi keluar: ' . $transaksiDetail['plat_nomor']
        );

        return redirect()->to('/transaksi/keluar')->with('success', 'Transaksi keluar berhasil diproses');
    }

    public function cetakStruk($id)
    {
        $check = $this->checkRole();
        if ($check) return $check;

        $transaksi = $this->transaksiModel->getTransaksiWithRelations($id);
        if (!$transaksi) {
            return redirect()->to('/transaksi/keluar')->with('error', 'Transaksi tidak ditemukan');
        }

        // Log aktivitas
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Mencetak struk transaksi: ' . $transaksi['plat_nomor']
        );

        $data = [
            'title' => 'Cetak Struk',
            'transaksi' => $transaksi
        ];

        return view('transaksi/struk', $data);
    }

    public function cetakStrukList()
    {
        $check = $this->checkRole();
        if ($check) return $check;

        // Log aktivitas
        $this->logModel->logActivity(
            session()->get('id_user'),
            'Mengakses halaman daftar struk'
        );

        // Ambil semua transaksi untuk debugging
        $allTransaksi = $this->transaksiModel->findAll();
        $selesaiTransaksi = $this->transaksiModel->getTransaksiSelesai();
        
        // Debug: Log jumlah transaksi
        log_message('debug', 'Total transaksi: ' . count($allTransaksi));
        log_message('debug', 'Transaksi selesai: ' . count($selesaiTransaksi));
        
        $data = [
            'title' => 'Daftar Struk',
            'transaksi' => $selesaiTransaksi,
            'all_transaksi' => $allTransaksi // Untuk debugging
        ];

        return view('transaksi/struk_list', $data);
    }
}
