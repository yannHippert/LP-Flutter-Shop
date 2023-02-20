<?php

namespace App\Entity;

use App\Repository\CategoryRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;


#[ORM\Entity(repositoryClass: CategoryRepository::class)]
#[ORM\Table(name: 'tblCategory')]
class Category
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['item:read'])]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['item:read'])]
    private ?string $name = null;

    #[ORM\OneToMany(mappedBy: 'category', targetEntity: Item::class)]
    private Collection $itemCategories;

    public function __construct()
    {
        $this->itemCategories = new ArrayCollection();
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

    /**
     * @return Collection<int, Item>
     */
    public function getItemCategories(): Collection
    {
        return $this->itemCategories;
    }

    public function addItemCategory(Item $itemCategory): self
    {
        if (!$this->itemCategories->contains($itemCategory)) {
            $this->itemCategories->add($itemCategory);
            $itemCategory->setCategory($this);
        }

        return $this;
    }

    public function removeItemCategory(Item $itemCategory): self
    {
        if ($this->itemCategories->removeElement($itemCategory)) {
            // set the owning side to null (unless already changed)
            if ($itemCategory->getCategory() === $this) {
                $itemCategory->setCategory(null);
            }
        }

        return $this;
    }
}
