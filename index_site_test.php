<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Dash-Board</title>
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

</head>
<body>
<div style="height: 150px">&nbsp;</div>
<div class="row">
    <div class="col-sm-4">&nbsp; </div>
    <div class="col-sm-4" style=" padding:20px ; border-radius: 8px; border:solid; border-color:lightblue;">

        <form role="form" action="./php/pss.php" method="post" >
            <div class="row">
                <div class="col-sm-3">
                    <br><br><br>
                    nom :<br><br>
                    passe :
                </div>
                <div class="col-sm-9">

                    <h2> Identification:<br></h2>
                    <input type="txt" class="form-control" name="nom" placeholder="Votre nom" required="required">
                    <input type="password" class="form-control" name="pss" placeholder="Votre passe"
                           required="required">
                    <button type="submit" class="btn btn-default"style ="background-color:aliceblue ">Valider</button>


                </div>
                </div>

            </div>
        </form>

    </div>
    <div class="col-sm-4">&nbsp; </div>

</div>
<script src="./jq/jquery-1.11.3/jquery-1.11.3.min.js"></script>

<script src="./js/ui-bootstrap-custom-tpls-0.14.3.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/fc.css">


</body>
</html>
