<?= $this->extend('templates/main_layout') ?>

<?= $this->section('content') ?>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-gradient text-white" style="background: linear-gradient(135deg, #00c6ff, #7b2ff7);">
                    <h4 class="mb-0">
                        <i class="fas fa-minus-circle me-2"></i>Transaksi Keluar
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

                    <?php if (empty($transaksi)): ?>
                        <div class="text-center py-5">
                            <i class="fas fa-car fa-4x text-muted mb-3"></i>
                            <h5 class="text-muted">Tidak ada transaksi aktif</h5>
                            <p class="text-muted">Belum ada kendaraan yang parkir saat ini</p>
                        </div>
                    <?php else: ?>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>No. Plat</th>
                                        <th>Jenis Kendaraan</th>
                                        <th>Waktu Masuk</th>
                                        <th>Status</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($transaksi as $t): ?>
                                        <?php if ($t['status'] === 'masuk'): ?>
                                        <tr>
                                            <td>
                                                <strong><?= $t['plat_nomor'] ?></strong>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">
                                                    <i class="fas fa-car me-1"></i><?= ucfirst($t['jenis_kendaraan']) ?>
                                                </span>
                                            </td>
                                            <td><?= date('d-m-Y H:i:s', strtotime($t['waktu_masuk'])) ?></td>
                                            <td>
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check-circle me-1"></i>Aktif
                                                </span>
                                            </td>
                                            <td>
                                                <form action="<?= site_url('/transaksi/keluar/' . $t['id_parkir']) ?>" method="post" class="d-inline">
                                                    <?= csrf_field() ?>
                                                    <button type="submit" class="btn btn-warning btn-sm" 
                                                            onclick="return confirm('Proses transaksi keluar untuk kendaraan <?= $t['plat_nomor'] ?>?')">
                                                        <i class="fas fa-sign-out-alt me-1"></i>Proses Keluar
                                                    </button>
                                                </form>
                                                <?php if ($t['status'] === 'selesai'): ?>
                                                    <a href="<?= site_url('/transaksi/struk/' . $t['id_parkir']) ?>" 
                                                       class="btn btn-info btn-sm ms-1" target="_blank">
                                                        <i class="fas fa-print me-1"></i>Cetak
                                                    </a>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                        <?php endif; ?>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    <?php endif; ?>

                    <div class="mt-3">
                        <a href="<?= site_url('/dashboard') ?>" class="btn btn-secondary btn-lg px-5">
                            <i class="fas fa-arrow-left me-2"></i>Kembali ke Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Auto refresh setiap 30 detik
setInterval(function() {
    window.location.reload();
}, 30000);
</script>

<?= $this->endSection() ?>
