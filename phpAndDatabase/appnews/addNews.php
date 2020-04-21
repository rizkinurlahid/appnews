<?php

require 'connect.php';
	
	if ($_SERVER['REQUEST_METHOD']=="POST") {
		$response = array();
		$title = $_POST['title'];
		$content = $_POST['content'];
		$description = $_POST['description'];
		$id_users = $_POST['id_users'];

		$image = date('dmYHis').str_replace(" ","", basename($_FILES['image']['name']));
		$imagePath = "upload/".$image;
		move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);



			$insert = "INSERT INTO tbl_news VALUE(NULL,'$image','$title','$content','$description',NOW(),'$id_users')";
			if (mysqli_query($connect, $insert)) {
				# code...
				$response['value']=1;
				$response['message']="Berhasil di tambahkan";
				echo json_encode($response);
			} else {
				# code...
				$response['value']=0;
				$response['message']="Gagal di ditambahkan";
				echo json_encode($response);
			}
		}
