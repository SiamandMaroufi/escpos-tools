<!doctype html>
<html>
    <head>
    </head>
    <body style="display:flex;flex-direction:row">

        <?php
            $content = $_REQUEST['base64'];
            if(isset($content)){
                $decoded = base64_decode($content);
                file_put_contents("decoded.escpos",$decoded);
                include("esc.php");

            }
        ?>

        <div>
            <form method="post">
                <textarea placeholder="Base64 ecnoded escpos commands" cols="100" rows="20" name="base64"><?php
                    echo $content;
                ?></textarea>
                <hr />
                <button type="submit" > Print </button>

            </form>
        </div>
    </body>
</html>
