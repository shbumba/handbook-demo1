<!DOCTYPE html>
<html lang="ru-RU">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8; IE=edge" />
    <title>Notebook</title>
    <link href="templates/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form method="post" name="sendParam">
        <table class="table style-2">
            <tr>
                <th colspan="2">Settings</th>
            </tr>
            <? foreach ($dataName as $key => $val): ?>
            <tr>
                <td><?= $val ?></td>
                <td><input type="number" name="sendParam[<?= $key ?>]" value="<?= $data[$key] ?>" /></td>
            </tr>
            <? endforeach; ?>
            <tr>
                <td colspan="2">
                    <input type="submit" value="send">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <? if ($result instanceof HandBook\Book): ?>
    <table class="table style-2">
        <tr>
            <th>№ NoteBook</th><th>Result</th>
        </tr>

        <? $timeTo = mktime(0, 0, 0, 1, 1, 2017); ?>

        <? foreach ($result->getResult() as $notebook): ?>
            <? if ($notebook instanceof HandBook\NoteBook): ?>
            <tr>
                <td><?= $notebook->getID() ?></td>

                <td class="no-padd">
                    <table class="table style-1">
                        <tr>
                            <th>Sheet</th>
                            <th>Front</th>
                            <th>Back</th>
                            <th>Front Time</th
                            ><th>Back Time</th>
                        </tr>

                    <? foreach ($notebook->getSheets() as $sheet): ?>
                        <? if ($sheet instanceof HandBook\Sheet): ?>
                        <tr>
                            <td><b><?= $sheet->getID() ?></b></td>

                            <? foreach ($sheet->getHands() as $hand => $page): ?>
                                <? if ($page instanceof HandBook\Page): ?>
                                    <td>
                                        start:  <b><?= $page->get('first') ?></b>
                                        <br/>
                                        end:  <b><?= $page->get('last') ?></b>
                                    </td>
                                <? endif; ?>
                            <? endforeach; ?>

                            <? foreach ($sheet->getHands() as $hand => $page): ?>
                                <? if ($page instanceof HandBook\Page): ?>
                                    <?
                                    $dayToFirst = (int)(($page->get('first') - 1) * 24 * 60 * 60);
                                    $dayToLast = (int)(($page->get('last') - 1) * 24 * 60 * 60);
                                    ?>
                                    <td>
                                        start:  <b><?= strftime('%h-%e', $timeTo + $dayToFirst) ?></b>
                                        <br/>
                                        end:  <b><?= strftime('%h-%e', $timeTo + $dayToLast) ?></b>
                                    </td>
                                <? endif; ?>
                            <? endforeach; ?>
                        </tr>
                        <? endif; ?>
                    <? endforeach; ?>

                    </table>
                </td>
            </tr>
            <? endif; ?>
        <? endforeach; ?>
        </table>
    <? endif; ?>
</body>
</html>
