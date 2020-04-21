<?php

	require 'connect.php';

	if ($_SERVER['REQUEST_METHOD'] == "POST") {
		$response = array();
		$title = $_POST['title'];
		$content = $_POST['content'];
		$description = $_POST['description'];
		$id_news = $_POST['id_news'];

		$image = date('dmYHis') . str_replace(" ", "", basename($_FILES['image']['name']));
		$imagePath = "upload/" . $image;
		move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);



		$insert = "UPDATE tbl_news SET image = '$image', title = '$title', content = '$content', description ='$description' WHERE id_news='$id_news'";
		if (mysqli_query($connect, $insert)) {
			# code...
			$response['value'] = 1;
			$response['message'] = "Berhasil di update";
			echo json_encode($response);
		} else {
			# code...
			$response['value'] = 0;
			$response['message'] = "Gagal di di update";
			echo json_encode($response);
		}
	}
