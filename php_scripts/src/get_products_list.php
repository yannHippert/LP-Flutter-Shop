<?php

namespace App;

error_reporting(E_ALL ^ E_DEPRECATED);

require __DIR__.'/../vendor/autoload.php';

use App\Entities\FirestoreConnector;

$firestoreConnector = new FirestoreConnector(__DIR__.'/../config/firestoreConfig.json');
$database = $firestoreConnector->getDatabase();
$products = $database->collection('products')->documents();

$productData = array_map(function ($product) {
    return $product->data();
}, iterator_to_array($products));

header('Content-Type: application/json');
echo json_encode($productData);
