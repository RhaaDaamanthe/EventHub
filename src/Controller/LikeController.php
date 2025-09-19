<?php

namespace App\Controller;

use App\Entity\Events;
use App\Entity\Likes;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class LikeController extends AbstractController
{
    #[Route('/event/{id}/like', name: 'app_event_like')]
    #[IsGranted('ROLE_USER')]
    public function like(Events $event, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        // On vérifie si l'utilisateur a déjà liké l'événement
        $like = $entityManager->getRepository(Likes::class)->findOneBy([
            'user' => $user,
            'event' => $event
        ]);

        if ($like) {
            // Si l'utilisateur a déjà liké, on supprime le like
            $entityManager->remove($like);
        } else {
            // Sinon, on crée un nouveau like
            $like = new Likes();
            $like->setUser($user);
            $like->setEvent($event);
            $entityManager->persist($like);
        }

        $entityManager->flush();

        // On retourne à la page de l'événement
        return $this->redirectToRoute('app_event_show', ['id' => $event->getId()]);
    }
}