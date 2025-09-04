<?php

namespace App\Entity;

use App\Repository\RegistrationsRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RegistrationsRepository::class)]
class Registrations
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'registrations')]
    #[ORM\JoinColumn(nullable: false)]
    private ?users $user_id = null;

    /**
     * @var Collection<int, events>
     */
    #[ORM\OneToMany(targetEntity: events::class, mappedBy: 'registrations', orphanRemoval: true)]
    private Collection $event_id;

    #[ORM\Column]
    private ?\DateTimeImmutable $registered_at = null;

    public function __construct()
    {
        $this->event_id = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserId(): ?users
    {
        return $this->user_id;
    }

    public function setUserId(?users $user_id): static
    {
        $this->user_id = $user_id;

        return $this;
    }

    /**
     * @return Collection<int, events>
     */
    public function getEventId(): Collection
    {
        return $this->event_id;
    }

    public function addEventId(events $eventId): static
    {
        if (!$this->event_id->contains($eventId)) {
            $this->event_id->add($eventId);
            $eventId->setRegistrations($this);
        }

        return $this;
    }

    public function removeEventId(events $eventId): static
    {
        if ($this->event_id->removeElement($eventId)) {
            // set the owning side to null (unless already changed)
            if ($eventId->getRegistrations() === $this) {
                $eventId->setRegistrations(null);
            }
        }

        return $this;
    }

    public function getRegisteredAt(): ?\DateTimeImmutable
    {
        return $this->registered_at;
    }

    public function setRegisteredAt(\DateTimeImmutable $registered_at): static
    {
        $this->registered_at = $registered_at;

        return $this;
    }
}
