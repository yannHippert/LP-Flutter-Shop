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

// First, check if wishlist exists for the customer

    $wishlist = $database->collection('wishlists')->document($inputArray['customer_id'])->snapshot();

    if (!$wishlist->exists()) {
        $errorList[] = 'Wishlist not found';
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

// Insert the variant in the wishlist (wishlists->items) create new document

    $newWishListItems = [
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

    $wishlistRef = $database->collection('wishlists')->document($inputArray['customer_id']);

    $wishlistRef->collection('items')->document($inputArray['variant_id'])->set($newWishListItems);

// Return success response
    echo json_encode(['success' => true]);

} catch (\Exception$e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'errors' => [$e->getMessage()]]);
}
