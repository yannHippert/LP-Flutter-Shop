<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\ApiProperty;
use Symfony\Component\Serializer\Annotation\Groups;
use App\Repository\VariantRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: VariantRepository::class)]
#[ORM\Table(name: 'tblVariant')]
//#[ApiResource()]
class Variant
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['item:read'])]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['item:read'])]
    private ?string $name = null;

    #[ORM\ManyToOne(inversedBy: 'variants')]
    #[Groups(['item:read'])]
    private ?Color $color = null;

    #[ORM\ManyToOne(inversedBy: 'variants')]
    #[Groups(['item:read'])]
    private ?Size $size = null;

    #[ORM\ManyToOne(inversedBy: 'variants')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Item $item = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['item:read'])]
    private ?int $price = null;

    #[ORM\ManyToMany(targetEntity: User::class, mappedBy: 'cart')]
    private Collection $inCarts;

    #[ORM\OneToMany(mappedBy: 'latestOrder', targetEntity: User::class)]
    private Collection $userOrders;

    #[ORM\ManyToMany(targetEntity: User::class, mappedBy: 'favourites')]
    private Collection $userFavourites;

    public function __construct()
    {
        $this->inCarts = new ArrayCollection();
        $this->userOrders = new ArrayCollection();
        $this->userFavourites = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getColor(): ?Color
    {
        return $this->color;
    }

    public function setColor(?Color $color): self
    {
        $this->color = $color;

        return $this;
    }

    public function getSize(): ?Size
    {
        return $this->size;
    }

    public function setSize(?Size $size): self
    {
        $this->size = $size;

        return $this;
    }

    public function getItem(): ?Item
    {
        return $this->item;
    }

    public function setItem(?Item $item): self
    {
        $this->item = $item;

        return $this;
    }

    public function getPrice(): ?int
    {
        return $this->price;
    }

    public function setPrice(?int $price): self
    {
        $this->price = $price;

        return $this;
    }

    public function getInCarts(): Collection
    {
        return $this->inCarts;
    }

    public function addInCart(User $inCart): self
    {
        if (!$this->inCarts->contains($inCart)) {
            $this->inCarts->add($inCart);
            $inCart->addCart($this);
        }

        return $this;
    }

    public function removeInCart(User $inCart): self
    {
        if ($this->inCarts->removeElement($inCart)) {
            $inCart->removeCart($this);
        }

        return $this;
    }

    /**
     * @return Collection<int, User>
     */
    public function getUserOrders(): Collection
    {
        return $this->userOrders;
    }

    public function addUserOrder(User $userOrder): self
    {
        if (!$this->userOrders->contains($userOrder)) {
            $this->userOrders->add($userOrder);
            $userOrder->setLatestOrder($this);
        }

        return $this;
    }

    public function removeUserOrder(User $userOrder): self
    {
        if ($this->userOrders->removeElement($userOrder)) {
            // set the owning side to null (unless already changed)
            if ($userOrder->getLatestOrder() === $this) {
                $userOrder->setLatestOrder(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, User>
     */
    public function getUserFavourites(): Collection
    {
        return $this->userFavourites;
    }

    public function addUserFavourite(User $userFavourite): self
    {
        if (!$this->userFavourites->contains($userFavourite)) {
            $this->userFavourites->add($userFavourite);
            $userFavourite->addFavourite($this);
        }

        return $this;
    }

    public function removeUserFavourite(User $userFavourite): self
    {
        if ($this->userFavourites->removeElement($userFavourite)) {
            $userFavourite->removeFavourite($this);
        }

        return $this;
    }
}
