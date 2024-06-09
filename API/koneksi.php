<?php

$koneksi = mysqli_connect("localhost", "root", "", "kamusDb");

if($koneksi){

	// echo "Database berhasil konek";
	
} else {
	echo "gagal Connect";
}

?>