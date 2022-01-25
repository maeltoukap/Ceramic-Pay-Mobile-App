<?php
    include "connexion.php";

    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {

            $req = $db->prepare("SELECT * FROM utilisateurs");
            // $req->execute(array($phone, $pass));
            // $result = mysqli_query($conn,$query) or die(mysql_error());
            // $exist = mysqli_num_rows($result);
            $exist = $req->rowCount();
            // print($exist);

            if($exist == 1){
                $array = $req->fetch();
                $msg = "Succes get";
                $succes = 1;
            }else{
                $msg = "Getting Error";
                $succes = 0;
            }
        }   catch (\Throwable $th) {
        $succes = 0;
        $mg = "Error: ".$th->getMessage();
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
?>