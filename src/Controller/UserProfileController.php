<?php
// src/Controller/UserProfileController.php

namespace App\Controller;

use App\Entity\Events;
use App\Entity\Users;
use App\Entity\Registrations;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class UserProfileController extends AbstractController
{
    #[Route('/user/profile/{id}', name: 'app_user_profile')]
    #[IsGranted('ROLE_ADMIN')]
    public function show(Users $user, EntityManagerInterface $entityManager): Response
    {
        // 1. Récupérer les événements créés par l'utilisateur
        $createdEvents = $entityManager->getRepository(Events::class)
            ->findBy(['created_by' => $user]);

        // 2. Récupérer les événements rejoints par l'utilisateur
        $registrations = $entityManager->getRepository(Registrations::class)
            ->findBy(['user_id' => $user]);

        $joinedEvents = [];
        foreach ($registrations as $registration) {
            $joinedEvents[] = $registration->getEventId();
        }

        return $this->render('profile/userProfile.html.twig', [
            'user' => $user,
            'createdEvents' => $createdEvents,
            'joinedEvents' => $joinedEvents,
        ]);
    }
}