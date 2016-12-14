<?php
require_once 'vendor/autoload.php';

date_default_timezone_set('Europe/Samara');
setlocale(LC_ALL, 'ru_RU.UTF-8');

try {
    $template = realpath('templates/template.tpl');

    $result = null;

    $sendData = isset($_REQUEST['sendParam']) ? (array) $_REQUEST['sendParam'] : null;

    $data = array(
        'total' => 366, //Total pages
        'pageSize' => 2, //Pages on one sheet
        'sheetSize' => 2, //The number of sides of the paper used
        'notebookSheet' => 4 //The number of sheets in a notebook
    );

    if (null !== $sendData) {
        $data = array_merge($data, $sendData);
    }

    $result = (new HandBook\Book($data))->run();

    $dataName = array(
        'total' => 'Total pages',
        'pageSize' => 'Pages on one sheet',
        'sheetSize' => 'The number of sides of the paper used',
        'notebookSheet' => 'The number of sheets in a notebook'
    );

    if ($template) {
        include $template;
    }
} catch (HandBook\Exception $e) {
    echo $e->getMessage() . "\n";
    echo implode("\n", $e->getErrors());
}