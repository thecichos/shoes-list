<?php
if ($_GET) {
  $getHash = $_GET["getHash"];
  if ($getHash == true) {
    exit(md5_file("json/cars.json"));
  }
}
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <script
  src="http://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
  crossorigin="anonymous"></script>
  <link rel="stylesheet" href="css/_main.css">
  <script src="js/_main.js"></script>
    <title>cars list</title>
  </head>
  <body>
    <div id="container">
      <table>
        <tr>
          <td><b>make</b></td>
          <td><b>model</b></td>
          <td><b>engine size</b></td>
          <td><b>action</b></td>
        </tr>
      <?php
        $file = file_get_contents("json/cars.json");

        $fileParsed = jsonLoad::__loadAndParse($file);
        for ($i=0; $i < count($fileParsed) ; $i++) {
          print_r("<tr>");
          print_r("<td><input type='text' value=".$fileParsed[$i]['make']." disabled></td>");
          print_r("<td><input type='text' value=".$fileParsed[$i]['model']." disabled></td>");
          if (isset($fileParsed[$i]["engine"]) == false) {
            print_r("<td><input type='text' value='not specified' disabled></td>");
          } else {
            print_r("<td><input type='text' value=".$fileParsed[$i]['engine']." disabled></td>");
          }
          print_r("</tr>");
        }
       ?>
     </table>
    </div>
  </body>
</html>

<?php
  /**
   *
   */
  class jsonLoad
  {

    function __loadAndParse($file)
    {
      return json_decode($file, true);
    }
  }

 ?>
