<?php
include "connexion.php";

$ville = $_POST["ville"];
$phone = $_POST["phone"];
// $newPassword = $_POST["password"];
$newPassword = sha1($_POST["pass"]);
$_POST = json_decode(file_get_contents('php://input'), true);
echo $_POST;
try {
    if (isset($phone, $newPassword)) {

        $req = $db->prepare("SELECT * FROM utilisateurs WHERE telephone=?");
        $req->execute(array($phone));
        $exist = $req->rowCount();

        if ($exist == 1) {
            $requ = $db->prepare("SELECT ville FROM utilisateurs WHERE telephone=? AND ville=?");
            $requ->execute(array($phone, $ville));
            $existe = $requ->rowCount();

            if ($existe == 1) {

                $request = $db->prepare("UPDATE utilisateurs SET password = ? WHERE telephone=?");
                $request->execute(array($newPassword, $phone));

                if ($request) {
                    $requ = $db->prepare("SELECT * FROM utilisateurs WHERE telephone=?");
                    $requ->execute(array($phone));
                    $array = $requ->fetch();
                    $succes = 1;
                    $msg = "Succes update";
                } else {
                    $succes = 0;
                    $msg = "Erreur de modification";
                }
            }else {
                $msg = "Ville incorrecte reessayer svp";
                $succes = 0;
            }
        } else {
            $msg = "Telephone Innexistant reessayer svp";
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
        $succes,
        $array,
        $existe
    ]
]);
    // echo json_encode([
    //     "result"=>[
    //         $name,
    //         $phone,
    //         $pass
    //     ]
    // ])
