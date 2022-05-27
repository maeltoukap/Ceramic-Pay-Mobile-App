<?php
include "connexion.php";

$idUser = $_POST["idUser"];
// $phone = $_POST["phone"];
// $newPassword = $_POST["password"];
// $newPassword = sha1($_POST["pass"]);
$_POST = json_decode(file_get_contents('php://input'), true);
echo $_POST;
try {
    if (isset($idUser)) {

        $request = $db->prepare("UPDATE scan SET valider = 2 WHERE idUser=?");
        $request->execute(array($idUser));

        if ($request) {
            $succes = 1;
            $msg = "Succes update";
        } else {
            $succes = 0;
            $msg = "Erreur de modification";
        }
    } else {
        $msg = "Utilisateur inconnu";
        $succes = 0;
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
