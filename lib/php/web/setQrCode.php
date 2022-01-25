<?php
    include "connexion.php";

    $qrCode = $_POST["qrCode"];
    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {
        if(isset($qrCode)){

            $req = $db->prepare("SELECT * FROM qr_code WHERE qrCode=?");
            $req->execute(array($qrCode));
            $exist = $req->rowCount();

            if($exist == 0){
                $req = $db->prepare("INSERT INTO qr_code VALUES (null, ?,)");
            $req->execute(array($qrCode));

            if ($req) {
                $succes = 1;
                $msg = "Succes set code";
            }else{
                $succes = 0;
                $msg = "Error insert";
            }
            }else{
                $msg = "qrCode already exist";
                $succes = 0;
            }
        }else{
            $succes = 0;
            $msg = "Error empty data";
        }

    } catch (\Throwable $th) {
        $succes = 0;
        $mg = "Error: ".$th->getMessage();
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
