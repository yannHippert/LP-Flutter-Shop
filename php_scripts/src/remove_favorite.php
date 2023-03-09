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
    
    $inputArray = [
        'id_customer' => $_GET['id_customer'] ?? null,
        'id_variant' => $_GET['id_variant'] ?? null,
    ];

    $errorList = [];



    function generateErrorResponse($errorList)
    {
        http_response_code(400);
        echo json_encode(['success' => false, 'errors' => $errorList]);
        exit;
    }

    // Check if the wishlist exists for the customer
    $wishlist = $database->collection('wishlists')->document($inputArray['id_customer'])->snapshot();

    if (!$wishlist->exists()) {
        $errorList[] = 'Wishlist not found';
        generateErrorResponse($errorList);
        exit;
    }

    // Go look for the variant in the wishlists collection

    $variant = $database->collection('wishlists')->document($inputArray['id_customer'])->collection('items')->document($inputArray['id_variant'])->snapshot();

    if (!$variant->exists()) {
        $errorList[] = 'Variant not found';
        generateErrorResponse($errorList);
        exit;
    }

    // Delete the variant from the wishlist

    $database->collection('wishlists')->document($inputArray['id_customer'])->collection('items')->document($inputArray['id_variant'])->delete();

    http_response_code(200);
    echo json_encode(['success' => true, 'message' => 'Variant removed from wishlist']);
    





}

catch (\Exception$e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'errors' => $e->getMessage()]);
}