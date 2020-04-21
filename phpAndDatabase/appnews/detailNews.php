<?php

require 'connect.php';
	
	$response = array();

	$sql = mysqli_query($connect, "SELECT a.*, b.username FROM tbl_news a LEFT JOIN tbl_users b on a.id_users = b.id_users ORDER BY a.id_users DESC");
	while ($a = mysqli_fetch_array($sql)) {
		# code...
		$b['id_news'] = $a['id_news'];
		$b['image'] = $a['image'];
		$b['title'] = $a['title'];
		$b['content'] = $a['content'];
		$b['description'] = $a['description'];
		$b['date_news'] = $a['date_news'];
		$b['id_users'] = $a['id_users'];
		$b['username'] = $a['username'];

		array_push($response, $b);
		
	}

	echo json_encode($response);
