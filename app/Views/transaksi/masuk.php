<?= $this->extend('templates/main_layout') ?>

<?= $this->section('content') ?>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-gradient text-white" style="background: linear-gradient(135deg, #00c6ff, #7b2ff7);">
                    <h4 class="mb-0">
                        <i class="fas fa-plus-circle me-2"></i>Transaksi Masuk
                    </h4>
                </div>
                <div class="card-body">
                    <?php if (session()->getFlashdata('success')): ?>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <?= session()->getFlashdata('success') ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>

                    <?php if (session()->getFlashdata('error')): ?>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <?= session()->getFlashdata('error') ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>

                    <form action="<?= site_url('/transaksi/store') ?>" method="post">
                        <?= csrf_field() ?>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="no_plat" class="form-label">
                                        <i class="fas fa-id-card me-2"></i>Nomor Plat
                                    </label>
                                    <input type="text" class="form-control form-control-lg" id="no_plat" name="no_plat" 
                                           placeholder="Contoh: B 1234 ABC" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="jenis_kendaraan" class="form-label">
                                        <i class="fas fa-car me-2"></i>Jenis Kendaraan
                                    </label>
                                    <select class="form-select form-select-lg" id="jenis_kendaraan" name="jenis_kendaraan" required>
                                        <option value="">Pilih Jenis Kendaraan</option>
                                        <?php foreach ($tarif as $t): ?>
                                            <option value="<?= $t['jenis_kendaraan'] ?>"><?= ucfirst($t['jenis_kendaraan']) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="id_area" class="form-label">
                                        <i class="fas fa-map-marker-alt me-2"></i>Area Parkir
                                    </label>
                                    <select class="form-select form-select-lg" id="id_area" name="id_area" required>
                                        <option value="">Pilih Area Parkir</option>
                                        <?php foreach ($area as $a): ?>
                                            <option value="<?= $a['id_area'] ?>"><?= $a['nama_area'] ?> (Kapasitas: <?= $a['kapasitas'] ?>)</option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="fas fa-clock me-2"></i>Waktu Masuk
                                    </label>
                                    <input type="text" class="form-control form-control-lg" value="<?= date('d-m-Y H:i:s') ?>" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary btn-lg px-5">
                                    <i class="fas fa-save me-2"></i>Simpan Transaksi
                                </button>
                                <a href="<?= site_url('/dashboard') ?>" class="btn btn-secondary btn-lg px-5 ms-2">
                                    <i class="fas fa-arrow-left me-2"></i>Kembali
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Auto format nomor plat
    const noPlat = document.getElementById('no_plat');
    noPlat.addEventListener('input', function(e) {
        let value = e.target.value.toUpperCase();
        value = value.replace(/[^A-Z0-9\s]/g, '');
        e.target.value = value;
    });
});
</script>

<?= $this->endSection() ?>
