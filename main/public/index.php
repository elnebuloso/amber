<!doctype html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title><?php echo getenv('APP_NAME'); ?></title>

    <link rel="stylesheet" href="/assets/bootstrap-4.3.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/index.css">
</head>
<body>

<div class="container h-100 d-flex flex-column">
    <div class="jumbotron my-auto">
        <h1 class="display-3"><?php echo getenv('APP_NAME'); ?></h1>
        <p class="lead"><?php echo getenv('APP_TEXT_LEAD'); ?></p>
    </div>
</div>
</main>

</body>
</html>