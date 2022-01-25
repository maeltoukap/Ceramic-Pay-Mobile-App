<?php
    include "../connexion.phpconnexion.php";

    $valider = 0;
    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {
        if(isset($valider)){

            $req = $db->prepare("SELECT * FROM scan WHERE valider=?");
            $req->execute(array($valider));
            // $result = mysqli_query($conn,$query) or die(mysql_error());
            // $exist = mysqli_num_rows($result);
            $exist = $req->rowCount();
            // print($exist);

            if($exist == 1){
                $array = $req->fetch();
                $msg = "Succes get scan";
                $succes = 1;
            }else{
                $msg = "Getting error";
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