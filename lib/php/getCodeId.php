
<?php
        include "connexion.php";
    
        try {
            $sql = "SELECT * FROM qr_code";
            $req = $db->query($sql);

            while ($a = $req->fetch()) {
                $result[] = $a['idCode'];
            }
        } catch (\Throwable $th) {
            echo "error:.$th->getMessage";
                print("Le qr code n'existe pas");
        }

        echo json_encode($result);
        // $phone = $_POST["phone"];
        // $pass = sha1($_POST["pass"]);
        // $_POST = json_decode(file_get_contents('php://input'), true);
        // echo $_POST;
        // try {
        //     $req = $db->prepare("SELECT * FROM qr_code WHERE qrCode=?");
        //     $req->execute(array("2911de3d4a559c3b27bdaea12021"));
        // } catch (\Throwable $th) {
        //     print("Le qr code n'existe pas");
        // }
        // try {
        //     // if(isset($qrCode)){
    
        //         $req = $db->prepare("SELECT * FROM qr_code WHERE qrCode=?);
        //         $req->execute(array($qrCode));
        //         -- 
    
        // } catch (\Throwable $th) {
        // }
?>