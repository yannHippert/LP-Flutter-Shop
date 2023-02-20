<?php

namespace App\Entity;

use App\Repository\ColorRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;


#[ORM\Entity(repositoryClass: ColorRepository::class)]
#[ORM\Table(name: 'tblColor')]
class Color
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['item:read'])]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['item:read'])]
    private ?string $name = null;

    #[ORM\OneToMany(mappedBy: 'color', targetEntity: Variant::class)]
    private Collection $variants;

    #[ORM\Column]
    #[Groups(['item:read'])]
    private ?int $r = null;

    #[ORM\Column]
    #[Groups(['item:read'])]
    private ?int $g = null;

    #[ORM\Column]
    #[Groups(['item:read'])]
    private ?int $b = null;

    public function __construct()
    {
        $this->variants = new ArrayCollection();
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
     * @return Collection<int, Variant>
     */
    public function getVariants(): Collection
    {
        return $this->variants;
    }

    public function addVariant(Variant $variant): self
    {
        if (!$this->variants->contains($variant)) {
            $this->variants->add($variant);
            $variant->setColor($this);
        }

        return $this;
    }

    public function removeVariant(Variant $variant): self
    {
        if ($this->variants->removeElement($variant)) {
            // set the owning side to null (unless already changed)
            if ($variant->getColor() === $this) {
                $variant->setColor(null);
            }
        }

        return $this;
    }

    public function getR(): ?int
    {
        return $this->r;
    }

    public function setR(int $r): self
    {
        $this->r = $r;

        return $this;
    }

    public function getG(): ?int
    {
        return $this->g;
    }

    public function setG(int $g): self
    {
        $this->g = $g;

        return $this;
    }

    public function getB(): ?int
    {
        return $this->b;
    }

    public function setB(int $b): self
    {
        $this->b = $b;

        return $this;
    }
}
