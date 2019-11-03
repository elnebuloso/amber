<!doctype html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title><?php echo getenv('APP_NAME'); ?></title>

    <link rel="stylesheet" href="/assets/bootstrap-4.3.1-dist/css/bootstrap.min.css">
</head>
<body>

<main role="main" class="container">
    <br>
    <div class="jumbotron">
        <h1 class="display-4"><?php echo getenv('APP_NAME'); ?></h1>
        <p class="lead"><?php echo getenv('APP_TEXT_LEAD'); ?></p>
    </div>
</main>

</body>
</html>