<?php

namespace App;

error_reporting(E_ALL);
header('Content-Type: application/json');

require __DIR__ . '/../vendor/autoload.php';
use App\Entities\FirestoreConnector;

try {
    $firestoreConnector = new FirestoreConnector(__DIR__ . '/../config/firestoreConfig.json');
    $database = $firestoreConnector->getDatabase();
    $products = $database->collection('products')->documents();

    $productData = array_map(function ($product) {
        return $product->data();
    }, iterator_to_array($products));

//status code 200 is default

    http_response_code(200);
    echo json_encode($productData);
} catch (\Exception$e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'errors' => $e->getMessage()]);
}
