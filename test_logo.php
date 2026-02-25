<?php
// Test untuk memastikan path dan base_url berfungsi
echo "Testing logo path...\n";
echo "ROOTPATH: " . ROOTPATH . "\n";
echo "Public path: " . ROOTPATH . 'public/logo-bcs.png' . "\n";
echo "File exists: " . (file_exists(ROOTPATH . 'public/logo-bcs.png') ? 'YES' : 'NO') . "\n";

// Test base_url
if (function_exists('base_url')) {
    echo "Base URL: " . base_url('logo-bcs.png') . "\n";
} else {
    echo "base_url function not available\n";
}

// Test site_url
if (function_exists('site_url')) {
    echo "Site URL: " . site_url('/') . "\n";
} else {
    echo "site_url function not available\n";
}
?>
