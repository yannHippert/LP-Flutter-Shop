<?php

namespace App;

error_reporting(E_ALL);
header('Content-Type: application/json');

require __DIR__ . '/../vendor/autoload.php';

use App\Entities\FirestoreConnector;

try {

    $firestoreConnector = new FirestoreConnector(__DIR__ . '/../config/firestoreConfig.json');
    $database = $firestoreConnector->getDatabase();

    $inputArray = [
        'customer_id' => $_GET['id_customer'] ?? null,
        'variant_id' => $_GET['id_variant'] ?? null,
        'id_product' => $_GET['id_product'] ?? null,
    ];

    $errorList = [];

    function generateErrorResponse($errorList)
    {
        http_response_code(400);
        echo json_encode(['success' => false, 'errors' => $errorList]);
        exit;
    }

    foreach ($inputArray as $key => $value) {
        if (empty($value) || $value === null) {
            $errorList[] = 'Missing ' . $key;
        }
    }
    if (!empty($errorList)) {
        generateErrorResponse($errorList);
    }

// First, check if basket exists for the customer


    $basket = $database->collection('basket')->document($inputArray['customer_id'])->snapshot();

    if (!$basket->exists()) {
        $errorList[] = 'Basket not found';
        generateErrorResponse($errorList);
        exit;
    }
    
   
// Go look for the product in firestore  products->variants->id

    $product = $database->collection('products')->document($inputArray['id_product'])->snapshot();
    $variant = null;

//find the variant that has the field id equal to the id_variant
    $variant = array_filter($product->data()['variants'], function ($variant) use ($inputArray) {
        return $variant['id'] === $inputArray['variant_id'];
    });

    if (empty($variant)) {
        $errorList[] = 'Product not found';
        generateErrorResponse($errorList);
        exit;
    }
    $variant = array_values($variant)[0];

// Insert the variant into the basket

    $newBasketItem = [
        "color" => $variant['color'] ?? null,
        "description" => $product->data()['description'],
        "id" => $variant['id'],
        "image" => $product->data()['image'],
        "name" => $product->data()['name'],
        "price" => $variant['price'],
        "productId" => $product->data()['id'],
        "quantity" => 1,
        "size" => $variant['size'] ?? null,
    ];

    $basketRef = $database->collection('basket')->document($inputArray['customer_id']);

    $basketRef->collection('items')->document($inputArray['variant_id'])->set($newBasketItem);

// Return success response
    echo json_encode(['success' => true]);

} catch (\Exception$e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'errors' => [$e->getMessage()]]);
}
