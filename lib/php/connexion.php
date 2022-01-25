<?php
    // $host = "localhost";
    // $dbname = "id18091189_ceramic";
    // $user = "id18091189_maeltoukap";
    // $pwd = "!P/-|95d?|^y8FMq";
    $host = "localhost";
    $dbname = "id18173419_ceramic";
    $user = "id18173419_maeltoukap";
    $pwd = "h<<bqL~wlw7B(mps";

    // $host = "127.0.0.1";
    // $dbname = "ceramicpay";
    // $user = "root";
    // $pwd = "";

        try {
            $db = new PDO("mysql:host=$host;dbname=$dbname",$user,$pwd);
            // echo 'connected';
        } catch (PDOException $th) {
            echo "Error: ".$th->getMessage();
        }
?>