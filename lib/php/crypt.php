<?php
    const key = "82a645babc5cd41c9a2cb4d0d3ba17ad";
    const iv = "hellotoutlemonde";
    const method = "aes-256-cbc";

    function encrypt($text){
        return openssl_encrypt($text, method, key, 0, iv);
    }

    function decrypt($text){
        return openssl_decrypt($text, method, key, 0, iv);
    }
?>