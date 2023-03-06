<?php
namespace App\Entities;


use Google\Cloud\Firestore\FirestoreClient;


class FirestoreConnector
{
    private FirestoreClient $firestoreClient;


    public function __construct(string $configPath)
    {
        $this->firestoreClient = new FirestoreClient([
            'keyFile' => json_decode(file_get_contents($configPath), true)
        ]);
    }

    public function getDatabase(): FirestoreClient
    {
        return $this->firestoreClient;
    }

}