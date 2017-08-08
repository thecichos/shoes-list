<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>cars list</title>
  </head>
  <body>
    <style media="screen">
      table tr {
        height: 20px;
      }
      table tr td {
        width: 125px;
        border-left: 1px solid black;
        margin: 0;
        padding: 2px;

      }
    </style>
    <table>
      <tr>
        <td><b>make</b></td>
        <td><b>model</b></td>
        <td><b>engine size</b></td>
      </tr>
    <?php
      $file = file_get_contents("json/cars.json");
      $fileParsed = json_decode($file, true);
      for ($i=0; $i < count($fileParsed) ; $i++) {

        print_r("<tr>");
        print_r("<td>" . $fileParsed[$i]['make'] . "</td>");
        print_r("<td>" . $fileParsed[$i]['model'] . "</td>");
        if (isset($fileParsed[$i]["engine"]) == false) {
          print_r("<td>not specified</td>");
        } else {
          print_r("<td>" . $fileParsed[$i]['engine'] . "</td>");
        }
        print_r("</tr>");
      }
     ?>
   </table>
  </body>
</html>
