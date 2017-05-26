<?php
// réalisé le 2016-01-27
    $user =  $_POST['nom'];
    $pass =  $_POST['pss'];
    if ($user == 'ec' and $pass == 'un23;'){
        header('Location:http://apch.co.nf/index_2.php');
        exit();

    }
?>