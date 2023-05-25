<?php
    include "connexion.php";

    $currentPhone = $_POST["currentPhone"];
    $newPhone = $_POST["newPhone"];
    // $pass = sha1($_POST["pass"]);
    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {
        if(isset($currentPhone, $newPhone)){

            $req = $db->prepare("SELECT * FROM utilisateurs WHERE telephone=?");
            $req->execute(array($newPhone));
            $exist = $req->rowCount();

            if($exist == 0){
                $request = $db->prepare("UPDATE utilisateurs SET telephone = ? WHERE telephone=?");
                $request->execute(array($newPhone, $currentPhone));

            if ($request) {
                $requ = $db->prepare("SELECT * FROM utilisateurs WHERE telephone=?");
                $requ->execute(array($newPhone));
                $array = $requ->fetch();
                $succes = 1;
                $msg = "Succes update";
            }else{
                $succes = 0;
                $msg = "Error update";
            }
            }else{
                $msg = "Phone already exist";
                $succes = 0;
            }
        }else{
            $succes = 0;
            $msg = "Error empty data";
        }

    } catch (\Throwable $th) {
        $succes = 0;
        $msg = "Error: ".$th->getMessage();
    }
    echo json_encode([
        'data' =>[
            $msg,
            $succes,
            $array
        ]
        ]);
    // echo json_encode([
    //     "result"=>[
    //         $name,
    //         $phone,
    //         $pass
    //     ]
    // ])
