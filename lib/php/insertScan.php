<?php
include "connexion.php";

// $qrCode = $_POST["qrCode"] = "9";
// // $idCode = $_POST["idCode"];
// $idUser = $_POST["idUser"] = "2511214d60d3679867f581372021";
$qrCode = $_POST["qrCode"];
$idUser = $_POST["idUser"];
$_POST = json_decode(file_get_contents('php://input'), true);
echo $_POST;
try {
    if (isset($qrCode, $idUser)) {

        $req = $db->prepare("SELECT idCode FROM qr_code WHERE qrCode=?");
        $req->execute(array($qrCode));
        $idCode = $req->fetch();
        $existCode = $req->rowCount();

        if ($existCode == 1) {

            $req = $db->prepare("SELECT idCode FROM scan WHERE idCode=?");
            $req->execute(array(json_encode($idCode)));
            // $a = $req->fetch();
            $existScan = $req->rowCount();
        }
        // $exist = $req->rowCount();


        if ($existScan == 0) {
            // INSERT INTO `scan` (`idScan`, `idUser`, `idCode`, `valider`) VALUES (NULL, '7', '2', '0');
            $req = $db->prepare("INSERT INTO scan(idUser, idCode) VALUES (?, ?)");
            $req->execute(array($idUser, json_encode($idCode)));

            if ($req) {
                $succes = 1;
                $msg = "Succes insert";
            } else {
                $succes = 0;
                $msg = "Error insert";
            }
        } else {
            $msg = "qr Code already exist";
            $succes = 0;
        }
    } else {
        $succes = 0;
        $msg = "Error empty data";
    }
} catch (\Throwable $th) {
    $succes = 0;
    $msg = "Error: " . $th->getMessage();
}
echo json_encode([
    'data' => [
        $msg,
        $succes
    ]
]);
    // echo json_encode([
    //     "result"=>[
    //         $name,
    //         $phone,
    //         $pass
    //     ]
    // ])
