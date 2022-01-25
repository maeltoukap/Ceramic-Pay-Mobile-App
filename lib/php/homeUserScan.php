<?php
    include "connexion.php";

    $idUser = $_POST["idUser"];
    // $valider = " ";
    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {

            // $req = $db->prepare("SELECT idCode FROM scan WHERE idUser=?");  
                $req = $db->prepare("SELECT] COUNT(S.idScan) AS scan, (COUNT(S.idScan)*400) AS merite FROM utilisateurs U, scan S, qr_codes Q WHERE S.idCode = Q.idCode AND S.idUser = ? AND S.valider = 0 GROUP BY S.idUser ORDER BY COUNT(S.idScan) DESC");
             //Count coupon of the current user
            $req->execute(array($idUser));
            while($a = $req->fetchAll()){
                $result[] = $a;
            }
            

    } catch (\Throwable $th) {
        $succes = 0;
        $msg = "Error: ".$th->getMessage();
    }
        echo json_encode(
                $result
                );
        // echo json_encode([
        //     'data' =>[
        //         $msg,
        //         $succes,
        //         $Coupon,
        //     ]
        //     ]);
?>
