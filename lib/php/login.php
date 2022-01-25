<?php
    include "connexion.php";
    include "crypt.php";

    $phone = $_POST["phone"];
    $pass = sha1($_POST["pass"]);
    $_POST = json_decode(file_get_contents('php://input'), true);
    echo $_POST;
    try {
        if(isset($phone, $pass)){

            $req = $db->prepare("SELECT * FROM utilisateurs WHERE telephone=? AND password=?");
            $req->execute(array($phone, $pass));
            // $result = mysqli_query($conn,$query) or die(mysql_error());
            // $exist = mysqli_num_rows($result);
            $exist = $req->rowCount();
            // print($exist);

            if($exist == 1){
                $array = $req->fetch();
                $msg = "Succes connection";
                $succes = 1;
            }else{
                $msg = "Email or password is incorrect";
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