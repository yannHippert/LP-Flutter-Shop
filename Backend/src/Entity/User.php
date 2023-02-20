<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[ORM\Table(name: 'tblUser')]
class User
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $username = null;

    #[ORM\Column(length: 255)]
    private ?string $firstName = null;

    #[ORM\Column(length: 255)]
    private ?string $lastName = null;

    #[ORM\Column(length: 255)]
    private ?string $email = null;

    #[ORM\Column(length: 255)]
    private ?string $password = null;

    #[ORM\ManyToMany(targetEntity: Variant::class, inversedBy: 'inCarts')]
    #[ORM\JoinTable(name: 'tblUserHasCart')]
    private Collection $cart;

    #[ORM\ManyToOne(inversedBy: 'userOrders')]
    private ?Variant $latestOrder = null;

    #[ORM\ManyToMany(targetEntity: Variant::class, inversedBy: 'userFavourites')]
    #[ORM\JoinTable(name: 'tblUserHasFavourite')]
    private Collection $favourites;

    public function __construct()
    {
        $this->cart = new ArrayCollection();
        $this->favourites = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUsername(): ?string
    {
        return $this->username;
    }

    public function setUsername(string $username): self
    {
        $this->username = $username;

        return $this;
    }

    public function getFirstName(): ?string
    {
        return $this->firstName;
    }

    public function setFirstName(string $firstName): self
    {
        $this->firstName = $firstName;

        return $this;
    }

    public function getLastName(): ?string
    {
        return $this->lastName;
    }

    public function setLastName(string $lastName): self
    {
        $this->lastName = $lastName;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    public function getCart(): Collection
    {
        return $this->cart;
    }

    public function addCart(Variant $cart): self
    {
        if (!$this->cart->contains($cart)) {
            $this->cart->add($cart);
        }

        return $this;
    }

    public function removeCart(Variant $cart): self
    {
        $this->cart->removeElement($cart);

        return $this;
    }

    public function getLatestOrder(): ?Variant
    {
        return $this->latestOrder;
    }

    public function setLatestOrder(?Variant $latestOrder): self
    {
        $this->latestOrder = $latestOrder;

        return $this;
    }

    /**
     * @return Collection<int, Variant>
     */
    public function getFavourites(): Collection
    {
        return $this->favourites;
    }

    public function addFavourite(Variant $favourite): self
    {
        if (!$this->favourites->contains($favourite)) {
            $this->favourites->add($favourite);
        }

        return $this;
    }

    public function removeFavourite(Variant $favourite): self
    {
        $this->favourites->removeElement($favourite);

        return $this;
    }
}
