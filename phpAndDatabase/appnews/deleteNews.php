<?php

require 'connect.php';
	
	if ($_SERVER['REQUEST_METHOD']=="POST") {
		$response = array();
		$id_news = $_POST['id_news'];

			$insert = "DELETE FROM tbl_news WHERE id_news ='$id_news'";
			if (mysqli_query($connect, $insert)) {
				# code...
				$response['value']=1;
				$response['message']="Berhasil di hapus";
				echo json_encode($response);
			} else {
				# code...
				$response['value']=0;
				$response['message']="Gagal di hapus";
				echo json_encode($response);
			}
		}
