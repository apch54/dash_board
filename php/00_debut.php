<!-- ..............................- -->
<!-- En tête ......................- -->
<!-- ..............................- -->

<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Dash-Board</title> 
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <script>document.write('<base href="' + document.location + '" />');</script>

</head>
<body id="id_body"
      ng-class="class_cursor"
      ng-app="app_mrc"
      ng-controller="ctl_mrc"
      ng-keyup="kb_event($event)"
      ng-keydown = "kb_event($event)"
      ng-cloak
>
<?php
include_once './php/03_tools.php'; // en premier !
//include_once '09_que_pour_la_production.php'; // connection à la bd
// include_once './php/01_navbar_top.php';

?>
