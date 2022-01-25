<?php
    include "connexion.php";

    $name = $_POST["name"];
    $phone = $_POST["phone"];
    $pass = sha1($_POST["pass"]);
    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {
        if(isset($name, $phone, $pass)){

            $req = $db->prepare("SELECT * FROM utilisateurs WHERE telephone=?");
            $req->execute(array($phone));
            $exist = $req->rowCount();

            if($exist == 0){
                $req = $db->prepare("INSERT INTO utilisateurs (nom, telelephone, password) VALUES (?, ?, ?)");
            $req->execute(array($name, $phone, $pass));

            if ($req) {
                $succes = 1;
                $msg = "Succes register";
            }else{
                $succes = 0;
                $msg = "Error register";
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
?>